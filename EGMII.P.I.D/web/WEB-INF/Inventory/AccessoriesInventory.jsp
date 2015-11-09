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
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
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
        <div style="width:70%">
            <table id="AccessoriesInventory" class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Item Code</th>
                        <th>Delivery Order Number</th>
                        <th>Purchase Number</th>
                        <th>Date Updated</th>
                        <th>Quantity</th>
                        <th>Updated By</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < AccessoriesInventory.size(); i++) {
                    %>
                    <tr>
                        <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                        <td><%=AccessoriesInventory.get(i).getQty()%></td>
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
