<%-- 
    Document   : DeliveryReceipt
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.BoutiqueInventory"%>
<%@page import="Model.AccessoriesInventory"%>
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
        <title>Boutique Inventory</title>
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
        <br/><br/><br/>
        <%        
        ArrayList<BoutiqueInventory> BoutiqueInventory = (ArrayList<BoutiqueInventory>) request.getAttribute("BoutiqueInventoryList");
        %>
    <center><h2>Boutique Inventory</h2></center>
    <div align="center" class="container">
        <table id="AccessoriesInventory" class="table table-bordered">
            <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Delivery Order Number</th>
                    <th>Purchase Number</th>
                    
                </tr>
            </thead>
            <tbody>
              
            </tbody>
        </table>
    </div>
</body>
</html>
