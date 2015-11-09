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
        <title>Warehouse Inventory</title>
        <script>
            $(document).ready(function () {
                $('#WarehouseInventory').DataTable({
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
        <table id="WarehouseInventory" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Delivery Number</th>
                    <th>Purchase Order Number</th>
                    <th>Production Number</th>
                    <th>Product ID</th>
                    <th>Size</th>
                    <th>Date Updated</th>
                    <th>Quantity</th>
                    <th>Updated by</th>
                </tr>
            </thead>
            <tbody>
                <% //for (int i = 0; i < WarehouseInventory.size(); i++) {%>
                <tr>
                    <td>90000000</td>
                    <td>70000000</td>
                    <td>30000000</td>
                    <td>20000011</td>
                    <td>XS</td>
                    <td>2015-11-01</td>
                    <td>100</td>
                    <td>Benjamin Yung</td>
                </tr>
                <%
                   // }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
