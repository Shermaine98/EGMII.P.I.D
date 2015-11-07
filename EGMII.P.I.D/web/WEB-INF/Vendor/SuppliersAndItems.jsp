<%-- 
    Document   : EncodeSuppliersAndItems
    Created on : 02 20, 15, 11:42:38 AM
    Author     : Shermaine
--%>
<%@page import="Model.RefSupplier"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="bootstrap/tableBoarder.css">
        <title>Supplier</title>

        <script>

        </script>


    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>Supplier</h2></center>

    <div></div>
    <%        ArrayList<RefSupplier> refSupplier = (ArrayList<RefSupplier>) request.getAttribute("RefSupplierList");
        ArrayList<Integer> refSupplierID = new ArrayList();
        for (int i = 0; i < refSupplier.size(); i++) {
            if (!refSupplierID.contains(refSupplier.get(i).getSupplierID())) {
                refSupplierID.add(refSupplier.get(i).getSupplierID());
            }
        }
    %>
    <div align="center">
        <select class = "form-control" onchange="updateHidden(this.value)">
            <option value="-1">Please Select Supplier</option>
            <%for (int i = 0; i < refSupplierID.size(); i++) {%>
            <option value = "<%=refSupplierID.get(i)%>">  <%=refSupplierID.get(i)%> </option>
            <%}%>

        </select>
        <div id="content">
            <table id="SupplierInformation" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
                <tbody></tbody>
            </table>
            <table id="productTable" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
                <thead>
                    <tr>
                        <th data-checkbox="true">Item Code</th>
                        <th data-sortable="true">Item Name</th>
                    </tr>
                </thead>
                <tbody></tbody>
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

        <div class="modal fade" id="myAddSupplier" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Item</h4>
                    </div>
                    <form  method="POST" action="EncodeSupplierServlet">
                        <div class="modal-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Supplier ID</th>
                                        <th>Supplier Company Name</th>
                                        <th>Supplier  Address</th>
                                        <th>Supplier Contact Person</th>
                                        <th>Supplier Contact Number</th>
                                        <th>item Code</th>
                                        <th>item Name</th>
                                    </tr>
                                </thead>
                                <tbody id = "dataTable2">
                                    <tr>
                                        <td><input type="checkbox" name="chk" /></td>
                                        <td><input type="text" class="form-control" placeholder="" name="suppliervalue" id="suppliervalue"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="companyName" id="companyName"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="companyAddress" id="companyAddress"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="contactPerson" id="contactPerson"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="contactNumber" id="contactNumber"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemCode" id="itemCode"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemName" id="itemName"></td>
                                    </tr>
                                </tbody> 
                            </table>  
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-danger" value="Add Row" onclick="addRow('dataTable2')" />
                            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable2')" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
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
        function updateHidden(x) {
            $("#suppliervalue").val(x);
            ajaxShow(x);
            console.log(x);
        }

        function ajaxShow(SupplierID) {
            console.log(SupplierID);
            $.ajax({
                url: "GetSuppliersAndItemForSuppliersServlet",
                type: 'POST',
                dataType: "json",
                data: {
                    SupplierID: SupplierID
                },
                success: function (data) {
                    $("#SupplierInformation tbody tr").remove();
                    $("#productTable tbody tr").remove();

                    $('#SupplierInformation').append('<tr><th>' + "Company Name" + '</th>' +
                            '<td>' + data[0].companyName + '</td>' +
                            '<th>' + "Company Address" + '</th>' +
                            '<td>' + data[0].companyAddress + '</td>' + '</tr>' +
                            '<tr><th>' + "Contact Person" + '</th>' +
                            '<td>' + data[0].contactPerson + '</td>' +
                            '<th>' + "Contact Person Number" + '</th>' +
                            '<td>' + data[0].contactNumber + '</td>'
                            + '</tr>');
                    var z = 0;
                    for (var y = 0; y < data.length; y++) {
                        if (data[y].supplierID == data[z].supplierID) {
                            $('#productTable').append('<tr><td>'
                                    + data[y].itemName + '</td><td>'
                                    + data[y].itemCode + '</td><td>'
                                    + '</tr><t/d>');
                        }
                        z++;
                    }
                },
                error: function (XMLHttpRequest, textStatus, exception) {
                    alert(XMLHttpRequest.responseText);
                }
            });
        }
    </script>
</body>

</html>
