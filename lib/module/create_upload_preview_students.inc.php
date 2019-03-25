<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; For navigation use &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
}else{

		if(!empty($_FILES["excel_file"])){
			$connect = mysqli_connect("localhost", "root", "", "adar");
			$file_array = explode(".", $_FILES["excel_file"]["name"]);
				if($file_array[1] == "xlsx"){
				include('PHPExcel/IOFactory.php');
				$output .= "
				<label class ='display'> Data Inserted</label>
					<table id='itemlist'  cellpadding='0' cellspacing='0' border='0' class='display' width='100%'>
						<tr>
							<th>studentNumber</th>
							<th>firstName</th>
							<th>surname</th>
							<th>gender</th>
							<th>course</th>
						</tr>
				";
				$objPHPExcel = PHPExcel_IOFactory :: load ($_FILES["excel_file"]["tmp_name"]);
				foreach($objPHPExcel -> getWorksheetIterator() as $worksheet){
					$highestRow = $worksheet -> getHighestRow();
					for($row = 2; $row <= $highestRow; $row ++){
						$student_number = mysqli_real_escape_string($worksheet -> getCellByColumnAndRow(1,$row) ->getValue());
						$name = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(2,$row) ->getValue());
						$surname = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(3,$row) ->getValue());
						$gender = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(4,$row) ->getValue());
						$course = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(5,$row) ->getValue());
						$query = "INSERT INTO student (studentNumber,firstName,surname,gender,course) values ('".$student_number."','".$name."','".$surname."','".$gender."','".$course."')";						
						$mysqli_query($connect,$query);
						$output.='
							<tr>
								<td>'.$student_number.'<td>
								<td>'.$name.'<td>
								<td>'.$surname.'<td>
								<td>'.$gender.'<td>
								<td>'.$course.'<td>
							</tr>
						';
					}
				}
				$output .= '</table>';
				echo $output;
			}
			else{
				echo '<label class="infobox_content"> Invalid File </label>';
			}
		}
	$titel = 'Students Upload From excel'; //list view
    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_students_upload');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'create_upload_preview_students');	
	}
?>
