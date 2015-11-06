<%-- 
    Document   : DeliveryReceipt
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.ProductionInventory"%>
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
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });
            });
        </script>
    </head>
    <body>  
        <%        
        ArrayList<ProductionInventory> ProductionInventory = (ArrayList<ProductionInventory>) request.getAttribute("ProductionInventoryList");
        %>
    <center><h2>Production Inventory</h2></center>
    <div align="center" class="container">
        <table id="productionInventory" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Production Number</th>
                    <th>Product ID</th>
                    <th>Size Type</th>
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
                    <td><%=ProductionInventory.get(i).getProductionNUmber()%></td>
                    <td><%=ProductionInventory.get(i).getProductID()%></td>
                    <td><%=ProductionInventory.get(i).getSizeType()%></td>
                    <td><%=ProductionInventory.get(i).getDrNumber()%></td>
                    <td><%=ProductionInventory.get(i).getPoNumber()%></td>
                    <td><%=ProductionInventory.get(i).getItemCode()%></td>
                    <td><%=ProductionInventory.get(i).getDateUpdated()%></td>
                    <td><%=ProductionInventory.get(i).getQty()%></td>
                    <td><%=ProductionInventory.get(i).getUpdatedBy()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
