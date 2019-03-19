<?PHP
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "adar";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
//Check the connection
if ($conn->connect_error){
  die ("Connection failed: ". $conn->connect_error);
}

$sql = "SELECT CID, FamilyName, GivenName, Type, Street, City, Country FROM contacts";
$result = $conn->query($sql);

if ($result->num_rows > 0){
  // Output data of each rows
  while($row = $result->fetch_assoc()){
    echo "CID:  " . $row['CID']. ",  Family Name:  " .$row['FamilyName'], ",   Given Name:  " .$row['GivenName'], ",  Type:  " .$row['Type'], ",   City:  " .$row['City'], ",   Country:  " .$row['Country']. "<BR>";"<BR>";;
  }
}else{
    echo "0 results";
  }

$conn->close();

//echo "Tetsing the page."
?>
