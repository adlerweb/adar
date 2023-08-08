#!/usr/bin/env python3

import importlib
import sys
import os
import traceback
import pprint
import mysql.connector
import hashlib
import shutil
import pdf2image
import datetime

modules = {}

shortId = "AD"
ScanUser = 1
dataFolder = "/src/http/adar/data"
DOCTYPE = "Brief"

sqlconnection = mysql.connector.connect(
      host="localhost",
      user="adar",
      passwd="testinstallation",
      database="adar")
sqlconnection.autocommit = False

def sha256file(filename):
  with open(filename, "rb") as f:
    hash_object = hashlib.sha256()
    for chunk in iter(lambda: f.read(4096), b""):
      hash_object.update(chunk)
  return hash_object.hexdigest()

def getNextId():
  cursor = sqlconnection.cursor()
  sql = "SELECT MAX(SUBSTRING(ItemID,4,4)) as UI_ID FROM `Items` WHERE `ItemID` LIKE %s"
  args = (f"{shortId}_%", )
  cursor.execute(sql, args)
  row = cursor.fetchone()
  if row is None:
    return None
  else:
    return f"{shortId}_" + str(int(row[0])+1)

def getContact(familyName, givenName = ""):
  cursor = sqlconnection.cursor()
  sql = "SELECT CID FROM Contacts WHERE FamilyName LIKE %s AND GivenName LIKE %s LIMIT 1;"
  args = (familyName, givenName)
  cursor.execute(sql, args)
  row = cursor.fetchone()
  if row is None:
    return None
  else:
    return row[0]

def convertToPng(filename, ItemID):
    outdir = dataFolder + "/cache/"
    pages = pdf2image.convert_from_path(filename)
    for i, page in enumerate(pages):
        outname = os.path.join(outdir, f"{ItemID}-{i}.png")
        #print(outname)
        page.save(outname)

def checkExists(hash):
  cur = sqlconnection.cursor()
  sql = "SELECT ItemID FROM `Items` WHERE `SourceSHA256` = %s"
  args = (hash, )
  cur.execute(sql, args)
  row = cur.fetchone()
  if row is None:
    return None
  else:
    return row[0]


def addFile(data, filename):
    ItemID = getNextId()
    cursor = sqlconnection.cursor()
    
    file_name, file_extension = os.path.splitext(filename)
    targetFile = dataFolder + "/org/" + ItemID + file_extension
    
    Hash = sha256file(filename)
    existID = checkExists(Hash)
    if existID:
        print(f"File already in database: {existID}")
        sys.exit(1)

    try:
        shutil.copy(filename, targetFile)
        convertToPng(filename, ItemID)

        chk = addItem(cursor, data, filename, ItemID, Hash)
        if not chk:
            print(chk)
            raise Exception("Error: addFile addItem failed")

        sqlconnection.commit()
    except Exception as error:
        sqlconnection.rollback()
        cursor.close()
        print("Failed to import item to database; rollback: {}".format(error))
        return False

    if 'tags' in data and type(data['tags']) == list:
        for tag in data['tags']:
            addTag(cursor, ItemID, tag)

    if 'custom' in data and type(data['custom']) is dict:
        for key, value in data['custom'].items():
            tag = key + "|" + str(value)
            addTag(cursor, ItemID, tag)
            
    return ItemID

def addItem(cursor, data, filename, ItemID, Hash):
    OCR = 1
    file_name, file_extension = os.path.splitext(filename)
    file_name = os.path.basename(filename)
    Caption = file_name
    Description = f"Automatically imported from {file_name} using scanFile.py\n\n"
    DocType = DOCTYPE
    Date = datetime.date.today().strftime("%Y-%m-%d")
    Sender = 0
    Receiver = 0

    if 'title' in data:
        Caption = data['title']
    if 'date' in data:
        Date = data['date']
    if 'receiver' in data:
        if ', ' in data['receiver']:
            Receiver = data['receiver'].split(', ')
            Receiver = getContact(Receiver[0], Receiver[1])
        else:
            Receiver = getContact(data['receiver'])
    if 'sender' in data:
        if ', ' in data['sender']:
            Sender = data['sender'].split(', ')
            Sender = getContact(Sender[0], Sender[1])
        else:
            Sender = getContact(data['sender'])
    if 'modules' in data and type(data['modules']) == list:
        Description = Description + "Used modules:\n"
        Description = Description + "-------------\n"
        for mod in data['modules']:
            Description = Description + f"* {mod}\n"
        rawData = pprint.pformat(data, indent=4)
        Description = Description + "-------------\n"
        Description = Description + "Raw Data:\n"
        Description = Description + "-------------\n"
        Description = Description + rawData
        Description = Description + "-------------\n"
        Description = Description + "\n\n"

    sql = "INSERT INTO `Items` (`ItemID`, `Caption`, `Description`, `Format`, `Date`, `Sender`, `Receiver`, `ScanUser`, `ScanDate`, `SourceSHA256`, `OCRStatus`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NOW(), %s, %s);"
    args = (ItemID, Caption, Description, DocType, Date, Sender, Receiver, ScanUser, Hash, OCR)
    
    cursor.execute(sql, args)
    return (cursor.rowcount > 0)

def addTag(cursor, ItemID, TagValue):
    sql = "INSERT INTO Tags (`ItemID`, `TagValue`) VALUES (%s, %s);"
    args = (ItemID, TagValue)
    cursor.execute(sql, args)
    return (cursor.rowcount > 0)

def getScriptPath():
    script_path = os.path.abspath(__file__)
    parent_directory = os.path.dirname(script_path)
    return parent_directory

def getModuleDir():
    return getScriptPath() + "/modules"

def getModules():
    directory = getModuleDir()
    module_names = []
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        if filename.endswith(".py"):
            module_name = os.path.splitext(filename)[0]
            module_names.append(module_name)
            continue
        else:
            continue
    return module_names

def addModulePath():
    module_path = getModuleDir()
    system_path = os.environ.get('PATH')
    path_directories = system_path.split(os.pathsep)
    if module_path not in path_directories:
        sys.path.append(module_path)

def loadModules(module_names = getModules()):
    # Import modules dynamically
    getModules()
    addModulePath()
    for module_name in module_names:
        try:
            module = importlib.import_module(module_name)
            modules[module_name] = module
        except ImportError:
            print(f"Error importing module: {module_name}")

def processFile(filename):
    out = {'modules': [], 'confidence': 0}
    for module_name, module in modules.items():
        try:
            if out['confidence'] < 1 or (hasattr(module, 'force') and module.force()):
                check = module.process_data(filename)
                if check is not False:
                    if 'confidence' in check:
                        if check['confidence'] > out['confidence']:
                            #print(f"Module {module_name} update higher prio")
                            #pprint.pprint(check['data'])
                            out.update(check['data'])
                            out['modules'].append(module_name)
                            out['confidence'] = check['confidence']
                        else:
                            #print(f"Module {module_name} update lower prio")
                            # Update metadata with fields not yet known
                            oldOut = out
                            out = check['data']
                            out.update(oldOut)
                            out['modules'].append(module_name)
        except Exception as e:
            print(module)
            print(f"Module {module_name} failed:")
            traceback.print_exc()
            continue
    return out

if len(sys.argv) != 2:
    print("Usage: scanFile.py <filename>")
    sys.exit(1)

filename = sys.argv[1]
loadModules()

if not os.path.exists(filename):
    print("File not found");
    sys.exit(1)

data = processFile(filename)
if(data and len(data['modules']) < 1):
    # Unprocessed
    print("No module matched file")
    data = []
elif 'confidence' in data and 'title' in data:
    # OK
    #print("OK?")
    next
else:
    print("Wat.")
    pprint.pprint(data)
    data = []
    #print("{}")
    #print(f"Seriously broken: {filename}")
    #pprint.pprint(data)
    #pprint.pprint(len(data['modules']))

newId = addFile(data, filename)
if newId:
    print(f"Added item {newId} from file {filename}")
else:
    print(f"Failed to add file {filename}")
    sys.exit(1)
