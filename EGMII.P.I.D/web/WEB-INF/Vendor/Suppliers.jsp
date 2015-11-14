<%-- 
    Document   : Supplier
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <title>Supplier</title>

        <script>
            function autoCompleteSupplier() {
                $("#supplierName").devbridgeAutocomplete({
                    serviceUrl: 'SearchSupplierServlet',
                    type: 'POST',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: 'No Exsiting Suppplier',
                    onSelect: function (event, ui) {
                        var supplierName = document.getElementById('supplierName').value;
                        $.ajax({
                            type: 'POST',
                            url: '',
                            dataType: 'json',
                            data: {
                                supplierName: supplierName
                            },
                            success: function (data) {
                                if (x) {
                                    $('#productTable').append('<tr><th>Item Name</th><th>Price</th></tr>');
                                    x = false;
                                }
                                //code appending etc
                                $('#productTable').append('<tr>\n\
                                <td><input type="hidden" name="" value="' + data[0].itemCode + '"/>\n\
                                    <input type="text" value="' + data[0].price + '"/> \n\
                                </td></tr>');
                            }
                        });
                    }
                });
            }

        </script>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>Supplier</h2></center>

    <div></div>
    <div class="input-group">
        <input type="text" class="form-control" name="supplierName" id="supplierName" onkeypress="autoCompleteSupplier()" placeholder="Search Item"/>
        <span class="input-group-btn">
            <a href="#" onClick="autoCompleteSupplier()" class="btn btn-default">
                <span class="glyphicon glyphicon-search"></span>
            </a></span>
    </div>


    <div align="center">
        <div id="content">
            <table id="SupplierInformation" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
                <tbody></tbody>
            </table>
            <table id="productTable" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
               
            </table>
        </div>

        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myAddItem">Add Item</button>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myAddSupplier">Add Supplier</button>

        <div class="modal fade" id="myAddItem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Item</h4>
                    </div>
                    <form action="EncodeItemServlet" method="POST">
                        <div class="modal-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Item Code<th>
                                        <th>Item Name<th>
                                    </tr>
                                </thead>
                                <tbody id ="dataTable1" >
                                    <tr> 
                                        <td><input type="checkbox" name="chk" /></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemCode" id="itemname"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemName" id="itemmodel"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="inventoryType" id="inventoryType"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <input type="hidden" name="suppliervalue" id="suppliervalue" value="">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <input type="button" class="btn btn-danger" value="Add Row" onclick="addRow('dataTable1')" />
                            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable1')" />
                        </div>
                    </form>
                </div>
            </div>
        </div>




        <br/><br/>

        <br/><br/>

        <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Exit</button></a>
    </div>
    <script>

    </script>
</body>

</html>
