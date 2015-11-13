<%-- 
    Document   : DeliveryReceipt
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.WarehouseInventoryView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="bootstrap/tableBoarder.css">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
         <script src="js/Validation.js"></script>
        <title>Warehouse Inventory</title>
        <script>
            $(document).ready(function () {
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
    </head>
    <body>  
        <%        ArrayList<WarehouseInventoryView> WarehouseInventory = (ArrayList<WarehouseInventoryView>) request.getAttribute("WarehouseInventoryList");
        %>
        <div align="center" class="container">
            <h2>Warehouse Inventory</h2>
            <table id="WarehouseInventory" class="table table-bordered">
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
        </div>
        <!-- for 0 qty -->
        <div align="center" class="container">
            <br/><br/>
            <h3>Out of Stock</h3>
            <table id="WarehouseInventory2" class="table table-bordered">
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
        <form method="POST" action="PrintWarehouseInventory" target="_blank">
            <div align="center">
                <input type="submit" class="btn btn-default" value="Save"/>
            </div>
        </form>
    </body>
</html>
