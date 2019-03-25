           <div class="infobox">
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/page_add.png" alt="" /> {$titel}
        </div>
        <div class="infobox_content">
            <form id="export_excel" action="index.php"  method="POST">
			    <label>Select an excel sheet</label>
                <input type="file" name="excel_file" style="width: 100%" id="excel_file"/>
               <input type="hidden" name="m" value="create_upload_preview_students" />
               <input type="submit" name="submit" value="submit" />
            </form>
			<br/>
			<br/>
			<div  id="result">
			
			
			</div>
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
				//url:"lib/module/create_upload_preview_students.inc.php", // pointing to my table where students can be found
				url:"export.php",
				//url:"api.php?source=student",
				method:"POST", 
				data:new FormData(this),
				contentType:false,
				processData:false;
				success:function(data){
					$('#result').html(data);
					$('#excel_file').val('');
				}
			});
		});
	});
</script>
