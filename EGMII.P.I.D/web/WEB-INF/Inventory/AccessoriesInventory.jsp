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
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <title>Accessories Inventory</title>
        <script>
            $(document).ready(function () {
                $('#AccessoriesInventory').DataTable({
                    "paging": true,
                    "info": true
                });
            });
        </script>
    </head>
    <body>  
        <br/>
        <%            ArrayList<RawMaterialsInventoryView> AccessoriesInventory = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("AccessoriesInventoryList");
        %>
        <div align="center" class="container">
            <h2>Accessories Inventory</h2>
            <div>
                <table id="AccessoriesInventory" class="table table-bordered table-hover">
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
                        %>
                        <tr>
                            <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                            <td><%=AccessoriesInventory.get(i).getItemName() %></td>
                            <td><%=AccessoriesInventory.get(i).getQty() %></td>
                            <td><%=AccessoriesInventory.get(i).getUnitMeasurement() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
