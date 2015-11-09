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
        <title>Production Inventory</title>
        <script>
            $(document).ready(function () {
                $('#productionInventory').DataTable({
                    "paging": true,
                    "info": true
                });
            });
        </script>
    </head>
    <body>  
        <%        
        ArrayList<RawMaterialsInventoryView> ProductionInventory = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("ProductionInventoryList");
        %>
    <center><h2>Production Inventory</h2></center>
    <div align="center" class="container">
        <table id="productionInventory" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Production Number</th>
                    <th>Product ID</th>
                    <th>Size</th>
                    <th>Delivery Number</th>
                    <th>Purchase Number</th>
                    <th>Item Code</th>
                    <th>Date Updated</th>
                    <th>Quantity</th>
                    <th>Updated By</th>
                </tr>
            </thead>
            <tbody>
                <%for (int i = 0; i < ProductionInventory.size(); i++) {%>
                <tr>
                    <td>30000001</td>
                    <td>2000000<%= i+1 %></td>
                    <td>XS</td>
                    <td>80000001</td>
                    <td>91000000</td>
                    <td><%=ProductionInventory.get(i).getItemCode()%></td>
                    <td>2015-11-10</td>
                    <td><%=ProductionInventory.get(i).getQty()%></td>
                    <td>Benjamin Yung</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
