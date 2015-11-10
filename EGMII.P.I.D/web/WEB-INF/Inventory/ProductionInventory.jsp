<%-- 
    Document   : DeliveryReceipt
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.RawMaterialsInventoryView"%>
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
        <title>Production Inventory</title>
        <script>
            $(document).ready(function () {
                $('#productionInventory').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#productionInventory2').DataTable({
                    "paging": true,
                    "info": true
                });
            });
        </script>
    </head>
    <body>  
        <%            ArrayList<RawMaterialsInventoryView> ProductionInventory = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("ProductionInventoryList");
        %>
    <center><h2>Production Inventory</h2></center>
    <div align="center" class="container">
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
    </div>

    <!-- for 0 qty -->
    <div align="center" class="container">
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
</body>
</html>
