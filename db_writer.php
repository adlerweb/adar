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

/*$dateUpload mysqli_real_escape_string($conn, $_REQUEST['upload_date']);
$dateModerated mysqli_real_escape_string($conn, $_REQUEST['moderate_date']);
$studentNo mysqli_real_escape_string($conn, $_REQUEST['student_number']);
$publishStatus mysqli_real_escape_string($conn, $_REQUEST['publish_status']);
$abstract mysqli_real_escape_string($conn, $_REQUEST['paper_abstract']);*/

$dateUpload = $_GET['upload_date'];
$dateModerated = $_GET['moderate_date'];
$studentNo = $_GET['student_number'];
$publishStatus = $_GET['publish_status'];
$abstract = $_GET['paper_abstract'];


$sql = "INSERT INTO papers (dateUploaded, dateModerated, studentNumber, publishedStatus, abstract) VALUES ($dateUpload, $dateModerated, '$studentNo', '$publishStatus', '$abstract')";

if(mysqli_query($conn, $sql)){
  echo "Records added successfully. ";
}
else {
  echo "ERROR: Could not able to excute $sql. " .mysql_error($conn);
}

mysqli_close($conn);
?>
