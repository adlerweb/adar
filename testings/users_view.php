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

$sql = "SELECT UserID, Name, Nickname FROM users";
$result = $conn->query($sql);

if ($result->num_rows > 0){
  // Output data of each rows
  while($row = $result->fetch_assoc()){
    echo "User id:  " . $row['UserID']. "  Name:  " .$row['Name'], "  Nickname:  " .$row['Nickname']. "<BR>";"<BR>";
  }
}else{
    echo "0 results";
  }

$conn->close();

echo "Tetsing the page."
?>
