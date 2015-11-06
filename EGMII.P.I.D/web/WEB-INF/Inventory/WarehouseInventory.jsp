<%-- 
    Document   : DeliveryReceipt
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.WarehouseInventory"%>
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
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });
            });
        </script>
    </head>
    <body>  
    <%            
     ArrayList<WarehouseInventory> WarehouseInventory = (ArrayList<WarehouseInventory>) request.getAttribute("WarehouseInventoryList");
    %>
    <center><h2>Warehouse Inventory</h2></center>
    <div align="center" class="container">
        <table id="WarehouseInventory" class="table table-bordered">
            <thead>
                <tr>
                    <th>Delivery Number</th>
                    <th>Purchase Order Number</th>
                    <th>Production Number</th>
                    <th>Product ID</th>
                    <th>Size Type</th>
                    <th>Date Updated</th>
                    <th>Quantity</th>
                    <th>Updated by</th>
                </tr>
            </thead>
            <tbody>
                <%for (int i = 0; i < WarehouseInventory.size(); i++) {%>
                <tr>
                    <td><%=WarehouseInventory.get(i).getDrNumber()%></td>
                    <td><%=WarehouseInventory.get(i).getPoNumber()%></td>
                    <td><%=WarehouseInventory.get(i).getProductionNumber()%></td>
                    <td><%=WarehouseInventory.get(i).getProductID()%></td>
                    <td><%=WarehouseInventory.get(i).getSizeType()%></td>
                    <td><%=WarehouseInventory.get(i).getDateUpdated()%></td>
                    <td><%=WarehouseInventory.get(i).getQty()%></td>
                    <td><%=WarehouseInventory.get(i).getUpdatedBy()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
       </div>
</body>
</html>
