<%-- 
    Document   : EncodeConsumptionReport
    Created on : 02 20, 15, 12:15:10 PM
    Author     : Shermaine
--%>


<%@page import="Model_View.WarehouseInventoryView"%>
<%@page import="Model_View.RawMaterialsInventoryView"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script src="js/Validation.js"></script>
        <title>Reconcile</title>

        <script>
            function showHide(divID) {
                document.getElementById('AItable').style.display = "none";
                document.getElementById('PItable').style.display = "none";
                document.getElementById('WItable').style.display = "none";
                if (document.getElementById(divID).style.display == "none") {
                    document.getElementById(divID).style.display = "block";
                }
            }

            $(document).ready(function () {
                $('#AccessoriesInventory').DataTable({
                    "paging": true,
                    "info": true
                });

                $('#AccessoriesInventory2').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#productionInventory').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#productionInventory2').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#WarehouseInventory').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#WarehouseInventory2').DataTable({
                    "paging": true,
                    "info": true
                });

            });
        </script>
        <style>
            img { 
                cursor: pointer; 
            }
            .btn {
                background-color: #B20000;
                color: #FFF;
                width:  250px;
                height: 35px;
                align-content: center
            }
        </style>

    </head>
    <body>  
        <div class="container" align="center" style="margin-top:30px;">
            <div style="margin-bottom: 50px;">
                <button id="AccessoriesInv" class="btn" onclick="showHide('AItable')" style="margin-right:15px;">Accessories</button>
                <button id="ProductionInv" class="btn" onclick="showHide('PItable')" style="margin-right:15px;">Production</button>
                <button id="WarehouseInv" class="btn" onclick="showHide('WItable')">Warehouse</button>
            </div>
        </div>
        <div style="width:70%" class="container" align="center">
            <%       ArrayList<RawMaterialsInventoryView> AccessoriesInventory = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("AccessoriesInventoryList");
            %>          
            <div id="AItable" style="display:none;">
                <h2>Accessories Inventory</h2>
                <table id="AccessoriesInventory" class="table-bordered table">
                    <thead>
                        <tr>
                            <th>Item Code</th>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Unit Measurement</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < AccessoriesInventory.size(); i++) {
                                if (AccessoriesInventory.get(i).getQty() > 0) {
                        %>
                        <tr>
                            <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                            <td><%=AccessoriesInventory.get(i).getItemName()%></td>
                            <td><%=AccessoriesInventory.get(i).getQty()%></td>
                            <td><%=AccessoriesInventory.get(i).getUnitMeasurement()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
                <!-- for 0 qty -->
                <br/><br/>
                <h3>Out of Stock</h3>
                <div>
                    <table id="AccessoriesInventory2" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Item Code</th>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Unit Measurement</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < AccessoriesInventory.size(); i++) {
                                    if (AccessoriesInventory.get(i).getQty() <= 0) {
                            %>
                            <tr>
                                <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                                <td><%=AccessoriesInventory.get(i).getItemName()%></td>
                                <td><%=AccessoriesInventory.get(i).getQty()%></td>
                                <td><%=AccessoriesInventory.get(i).getUnitMeasurement()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table> 
                </div>
            </div>
        </div>
        <!--Production-->                       

        <div class="container"style="width:70%"  align="center">
            <div id="PItable" style="display:none;">
                <%
                    ArrayList<RawMaterialsInventoryView> ProductionInventory = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("ProductionInventoryList");
                %>    
                <h2>Production Inventory</h2>
                <table id="productionInventory" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Item Code</th>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Unit Measurement</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < ProductionInventory.size(); i++) {
                                if (ProductionInventory.get(i).getQty() > 0) {
                        %>
                        <tr>
                            <td><%=ProductionInventory.get(i).getItemCode()%></td>
                            <td><%=ProductionInventory.get(i).getItemName()%></td>
                            <td><%=ProductionInventory.get(i).getQty()%></td>
                            <td><%=ProductionInventory.get(i).getUnitMeasurement()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
                <!-- for 0 qty -->
                <br/><br/>
                <h3>Out of Stock</h3>
                <table id="productionInventory2" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Item Code</th>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Unit Measurement</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < ProductionInventory.size(); i++) {
                                if (ProductionInventory.get(i).getQty() <= 0) {
                        %>
                        <tr>
                            <td><%=ProductionInventory.get(i).getItemCode()%></td>
                            <td><%=ProductionInventory.get(i).getItemName()%></td>
                            <td><%=ProductionInventory.get(i).getQty()%></td>
                            <td><%=ProductionInventory.get(i).getUnitMeasurement()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
            <!--Warehouse-->   
            <%
                ArrayList<WarehouseInventoryView> WarehouseInventory = (ArrayList<WarehouseInventoryView>) request.getAttribute("WarehouseInventoryList");
            %>
            <div class="container" align="center">
                <div id="WItable" style="display:none;">
                    <h2>Warehouse Inventory</h2>
                    <table id="WarehouseInventory" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < WarehouseInventory.size(); i++) {
                                    if (WarehouseInventory.get(i).getQty() > 0) {
                            %>
                            <tr>
                                <td><%=WarehouseInventory.get(i).getItemCode()%></td>
                                <td><%=WarehouseInventory.get(i).getProductName()%></td>
                                <td><%=WarehouseInventory.get(i).getProductType()%></td>
                                <td><%=WarehouseInventory.get(i).getColor()%></td>
                                <td><%=WarehouseInventory.get(i).getSize()%></td>
                                <td><%=WarehouseInventory.get(i).getQty()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>

                    <!-- for 0 qty -->
                    <br/><br/>
                    <h3>Out of Stock</h3>
                    <table id="WarehouseInventory2" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < WarehouseInventory.size(); i++) {
                                    if (WarehouseInventory.get(i).getQty() <= 0) {
                            %>
                            <tr>
                                <td><%=WarehouseInventory.get(i).getItemCode()%></td>
                                <td><%=WarehouseInventory.get(i).getProductName()%></td>
                                <td><%=WarehouseInventory.get(i).getProductType()%></td>
                                <td><%=WarehouseInventory.get(i).getColor()%></td>
                                <td><%=WarehouseInventory.get(i).getSize()%></td>
                                <td><%=WarehouseInventory.get(i).getQty()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
    </body>
</html>