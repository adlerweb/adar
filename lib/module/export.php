<?php
				if(!empty($_FILES["excel_file"])){
			$connect = mysqli_connect("localhost", "root", "", "adar");
			$file_array = explode(".", $_FILES["excel_file"]["name"]);
				if($file_array[1] == "xlsx"){
				//include('C:\xampp\htdocs\Backup\adar-master\PHPExcel\IOFactory.php');
				require_once 'PHPExcel.php';
				include'PHPExcel\IOFactory.php';
				$output = "<table border='1'>";
				$objPHPExcel = PHPExcel_IOFactory :: load ($_FILES["excel_file"]["tmp_name"]);
				foreach($objPHPExcel -> getWorksheetIterator() as $worksheet){
					$highestRow = $worksheet -> getHighestRow();
					for($row = 2; $row <= $highestRow; $row ++){
						$output .= "<tr>";
						$student_number = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(0,$row) ->getValue());
						$name = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(1,$row) ->getValue());
						$surname = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(2,$row) ->getValue());
						$gender = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(3,$row) ->getValue());
						$course = mysqli_real_escape_string($connect, $worksheet -> getCellByColumnAndRow(4,$row) ->getValue());
						$query = "INSERT INTO student (studentNumber,firstName,surname,gender,course) values ('".$student_number."','".$name."','".$surname."','".$gender."','".$course."')";						
						mysqli_query($connect,$query);
							$output.='<td>'.$student_number.'<td>';
							$output.='<td>'.$name.'<td>';
							$output.='<td>'.$surname.'<td>';
							$output.='<td>'.$gender.'<td>';
							$output.='<td>'.$course.'<td>';
							$output.= "</tr>";
					}
				}
				$output .= '</table>';
				echo $output;
				echo '<br/> Data inserted successfully';
			}
			else{
				echo '<label class="infobox_content"> Invalid File </label>';
			}
		}
?>