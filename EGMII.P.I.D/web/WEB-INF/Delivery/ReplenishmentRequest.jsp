<%-- 
    Document   : ReplenishmentRequest
    Created on : 11 4, 15, 10:06:53 PM
    Author     : Geraldine
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
                $('#Replenish').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#invR').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#warehouseT').DataTable({
                    "paging": true,
                    "info": true,
                    "aoColumnDefs": [
                        {"bSearchable": false, "bVisible": true, "aTargets": [0]}
                    ]
                });

                $("#Replenish tbody").on("click", 'input[type="text"]', (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".reportID").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));

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
            <!--Click Inventory Reports-->
            <%        ArrayList<InventoryReportView> InventoryReport = (ArrayList<InventoryReportView>) request.getAttribute("inventoryReports");
                if (InventoryReport.size() > 0) {
            %>
            <form id="form1" method="POST" action="ViewReplenishmentServlet?action=specific">
                <div class="container" align="center">
                    <h2>Inventory Reports</h2><br/>
                    <div style="width:60%;">
                        <table id="Replenish" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Report ID</th>
                                    <th>Branch Name</th>
                                    <th>Promoter</th>
                                    <th>Date Made</th>

                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < InventoryReport.size(); i++) {%>
                                <tr class="repView">
                                    <td class="reportID"><%=InventoryReport.get(i).getReportID()%><input type="text" class="transparentBg inputSize"></td>
                                    <td><input type="text" class="transparentBg inputSize" value="<%=InventoryReport.get(i).getBranchName()%>"></td>
                                    <td><input type="text" class="transparentBg inputSize" value="<%=InventoryReport.get(i).getPromo()%>"</td>
                                    <td><input type="text" class="transparentBg inputSize" value="<%=InventoryReport.get(i).getDateMade()%>"</td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <input type="hidden" name="invId" id="hiddenValue" value=""/>
                </div>
            </form>

            <%
                String data = (String) request.getAttribute("data");
                if (data.equalsIgnoreCase("specific")) {
                    ArrayList<InventoryReportCom> InventoryReportS = (ArrayList<InventoryReportCom>) request.getAttribute("InventoryReportCom");
                    ArrayList<WarehouseInventoryView> warehouseInv = (ArrayList<WarehouseInventoryView>) request.getAttribute("warehouseView");
                    Integer repID = (Integer) request.getAttribute("repID");
            %>


            <!--Inventory Report Data Table-->

            <h2>Inventory Report Details</h2><br/>
            <div style="width:60%;">
                <table id="invR" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Sold Out</th>
                            <th>Pulled Out</th>
                            <th>Current Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < InventoryReportS.size(); i++) {%>
                        <tr>
                            <td><%=InventoryReportS.get(i).getProductName()%></td>
                            <td><%=InventoryReportS.get(i).getColor()%></td>
                            <td><%=InventoryReportS.get(i).getSize()%></td>
                            <td><%=InventoryReportS.get(i).getSoldQty()%></td>
                            <td><%=InventoryReportS.get(i).getPulledQty()%></td>
                            <td><%=InventoryReportS.get(i).getCurrentQty()%></td>
                        </tr>
                        <%

                            }
                        %>
                    </tbody>
                </table>
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
                        <input type="hidden" class="form-control" readonly name="location" value="<%=InventoryReportS.get(0).getLocationID()%>" /><br/>
                        <input type="text" class="form-control" readonly name="outlet" value="<%=InventoryReportS.get(0).getBranchName()%>" />
                        <label for="promo">Promoter</label>
                        <input type="hidden" class="form-control" readonly name="promo" value="<%=InventoryReportS.get(0).getPromoid()%>" />
                        <input type="text" class="form-control" readonly  value="<%=InventoryReportS.get(0).getName()%>" /><br/>
                        <label for="date">Date Inventory </label>
                        <input type="text" class="form-control" readonly name="date" value="<%=InventoryReportS.get(0).getDateMade()%>" /><br/>
                        <label for="repID">Replenishment ID</label>
                        <input type="text" class="form-control" readonly name="repID" value="<%=repID%>" /><br/>
                        <input type="hidden" class="form-control" readonly name="supervisor" value="<%=user.getEmployeeNumber()%>" /><br/>
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


                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>
