<table id="itemlist"  cellpadding="0" cellspacing="0" border="0" class="display" width="100%">
    <thead>
        <tr>
            <th>cluster Id</th>
            <th>cluster Name</th>

            <th>Description</th>
        </tr>
    </thead>
    <!--thead>
        <tr>
            <td><input type="text" id="0" class="itemlist-input"></td>
            <td><input type="text" id="1" class="itemlist-input"></td>
            <td><input type="text" id="2" class="itemlist-input" ></td>
        </tr>
    </thead-->
</table>

<a href="?m=cluster_create">
<input type="submit" name="a" value="Record a Cluster" />
</a>

<script type="text/javascript" language="javascript" >
    $(document).ready(function() {
        var dataTable = $('#itemlist').DataTable( {
            /*dom: 'Bfrtipl',
            buttons: [
                'selected',
                'selectAll',
                'selectNone',
            ],*/
            select: false,
            processing: true,
            serverSide: true,
            ajax:{
                url :"api.php?source=cluster", // json datasource
                type: "post",  // method  , by default get
                /*error: function(){  // error handling
                    $(".itemlist-error").html("");
                    $("#itemlist").append('<tbody class="itemlist-error"><tr><th colspan="6">No data found in the server</th></tr></tbody>');
                    $("#itemlist_processing").css("display","none");
                }*/
            },
            "order": [[ 2, "desc" ]]
        } );

        $('.itemlist-input').on( 'keyup click change', function () {
            var i =$(this).attr('id');  // getting column index
            var v =$(this).val();  // getting search input value
            dataTable.columns(i).search(v).draw();
        } );
    } );
</script>
