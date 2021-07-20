           <div class="infobox" >
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/page_add.png" alt="" /> {$titel}<img src="vendor/koala-framework/library-silkicons/user_add.png" />
        </div>
        <div class="infobox_content">
            <form id="export_excel" action="index.php"  method="POST">
			    <label>Select an excel sheet</label>
                <input type="file" name="excel_file" style="width: 100%" id="excel_file"/>
               <input type="hidden" name="m" value="create_upload_preview_students" />
            </form>
			<br/>
			<br/>
			<div  id="result">
			
			
			</div>
		<a href="?m=student_list">
		<input type="submit" name="a" value="View the latest list of students" />
		</a>
        </div>
    </div>

<script>	// this following script will be exporting the data from excel to the given name table......
    $(document).ready(function(){
	    $('#excel_file').change(function(){
			$('#export_excel').submit();
		});
		$('#export_excel').on('submit', function(event){
			event.preventDefault();
			$.ajax({   
                // this is the link to an external export file.........
				url:"lib/module/export.php",
				method:"POST", 
				data:new FormData(this),
				contentType:false,
				processData:false,
				success:function(data){
					$('#result').html(data);
					$('#excel_file').val('');
				}
			});
		});
	});
</script>
