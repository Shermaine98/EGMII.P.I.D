<%-- 
    Document   : Replenishment Request
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.WarehouseInventoryView"%>
<%@page import="Model.InventoryReportCom"%>
<%@page import="Model_View.InventoryReportView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchWarehouse.js"></script>
        <script src="js/Validation.js"></script>
        <title>Replenishment Request</title>
        <style>
        </style>
        <script>
            $(document).ready(function () {
             
                $('#warehouseT').DataTable({
                    "paging": true,
                    "info": true,
                    "aoColumnDefs": [
                        {"bSearchable": false, "bVisible": true, "aTargets": [0]}
                    ]
                });
              
                $('#warehouseT tbody').on('click', 'input[type="checkbox"]', function (e) {
                    var check = this.checked;
                    var index = $(this).closest("tr").index();
                    if (check === true) {
                        document.getElementById("order").style.visibility = 'visible';
                        document.getElementById("buttonz").style.visibility = 'visible';
                        var itemCode = $(this).closest("tr").find(".itemCode").text();
                        console.log(itemCode);
                        var productName = $(this).closest("tr").find(".productName").text();
                        var color = $(this).closest("tr").find(".color").text();
                        var size = $(this).closest("tr").find(".size").text();
                        var Qty = $(this).closest("tr").find(".Qty").text();
                        $('#data').append('<tr id="rowNum' + index + '">\n\
                                      <td><input type="hidden" name="itemCode" value="' + itemCode + '"/>\n\
                                           <input type="text" value="' + productName + '"/></td>\n\
                                      <td><input type="text"  value="' + color + '"/></td>\n\
                                      <td><input type="text" value="' + size + '"/></td>\n\\n\
                                      <td><input type="text" value="' + Qty + '"/></td>\n\\n\
                                      <td><input type="number" name="qty" value="0"/></td>\n\
                                    </tr>');
                    } else {
                        $('#data').find("#rowNum" + index).remove();
                    }
                });
            });



        </script>
    </head>
    <body>


        <div class="container" align="center">
            <h2>Replenishment Request</h2>
            <%
             
                    ArrayList<WarehouseInventoryView> warehouseInv = (ArrayList<WarehouseInventoryView>) request.getAttribute("warehouseView");
                    Integer repID = (Integer) request.getAttribute("repID");
            %>


            <!--Inventory Report Data Table-->

            <h2>Inventory Report Details</h2><br/>
            <div style="width:60%;">
                
                <div style="width:60%;">
                    <table id="warehouseT" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Order</th>
                                <th>Item Code</th>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Current Quantity</th>

                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < warehouseInv.size(); i++) {%>
                            <tr>
                                <td class="check" ><input type = "checkbox" value="1"/></td>
                                <td class="itemCode"><%=warehouseInv.get(i).getItemCode()%></td>
                                <td class="productName"><%=warehouseInv.get(i).getProductName()%></td>

                                <td class="color"><%=warehouseInv.get(i).getColor()%></td>
                                <td class="size"><%=warehouseInv.get(i).getSize()%></td>
                                <td class="Qty"><%=warehouseInv.get(i).getQty()%></td>

                            </tr>

                            <%

                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>         
        </div>
        <div class="container" align="center">
            <form method="POST" action="EncodeReplenishmentRequestServlet"> 
                <div class="panel panel-default col-md-3">

                    <div class="panel-body">
                        <label for="outlet">Outlet</label>
                        <input type="hidden" class="form-control" readonly name="location" value="" /><br/>
                        <input type="text" class="form-control" readonly name="outlet" value="" />
                        <label for="promo">Promoter</label>
                        <input type="hidden" class="form-control" readonly name="promo" value="" />
                        <input type="text" class="form-control" readonly  value="" /><br/>
                        <label for="date">Date Inventory </label>
                        <input type="text" class="form-control" readonly name="date" value="" /><br/>
                        <label for="repID">Replenishment ID</label>
                        <input type="text" class="form-control" readonly name="repID" value="" /><br/>
                        <input type="hidden" class="form-control" readonly name="supervisor" value="" /><br/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <br> 
                    <h2>Warehouse Inventory</h2><br/>
                    <div id="order" style=" width:60%; visibility: hidden">
                        <h2>Replenishment Request</h2><br/>
                        <table id="data" class="table table-bordered" >
                            <thead>
                                <tr>

                                    <th>Product Name</th>
                                    <th>Color</th>
                                    <th>Size</th>
                                    <th>Current Quantity</th>
                                    <th>Quantity To Be send (?)</th>
                                </tr>
                            </thead>
                            <tbody id="info">

                            </tbody>
                        </table>
                    </div>
                    <br>
                </div>


                <!--Buttons-->
                <div id="buttonz" align="center" style="visibility: hidden">
                    <input type="submit" class="btn btn-default" value="SUBMIT"/>
                </div>


                
            </form>
        </div>
    </body>
</html>
