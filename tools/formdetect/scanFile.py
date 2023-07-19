import importlib
import sys
import os
import traceback
import pprint

modules = {}

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
    out = {'Modules': [], 'confidence': 0}
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
                            out['Modules'].append(module_name)
                            out['confidence'] = check['confidence']
                        else:
                            #print(f"Module {module_name} update lower prio")
                            # Update metadata with fields not yet known
                            oldOut = out
                            out = check['data']
                            out.update(oldOut)
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
if(data and len(data['Modules']) < 1):
    # Unprocessed
    print("{}")
elif 'title' in data and 'confidence' in data:
    # OK
    pprint.pprint(data)
else:
    print("{}")
    #print(f"Seriously broken: {filename}")
    #pprint.pprint(data)
    #pprint.pprint(len(data['Modules']))
