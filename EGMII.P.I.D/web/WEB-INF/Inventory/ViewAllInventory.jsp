<%-- 
    Document   : EncodeConsumptionReport
    Created on : 02 20, 15, 12:15:10 PM
    Author     : Shermaine
--%>

<%@page import="Model.SupplierPurchaseOrder"%>
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
        </script>
        <style>
            img { 
                cursor: pointer; 
            }
        </style>

    </head>
    <body>  
        <div class="container" align="center" style="margin-top:50px;">
            <div style="margin-bottom: 50px;">
                <img src="Images/AI.png" id="AccessoriesInv" onclick="showHide('AItable')" style="margin-right:15px;" />
                <img src="Images/PI.png" id="ProductionInv"  onclick="showHide('PItable')" style="margin-right:15px;" />
                <img src="Images/wi.png" id="WarehouseInv"  onclick="showHide('WItable')" />
            </div>
            <div id="AItable" style="display:none;">
                <table class="table-bordered table">
                    <thead>
                        <tr>
                            <th>Accessories Inventory</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Content</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="PItable" style="display:none;">
                <table class="table-bordered table">
                    <thead>
                        <tr>
                            <th>Production Inventory</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Content</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="WItable" style="display:none;">
                <table class="table-bordered table">
                    <thead>
                        <tr>
                            <th>Warehouse Inventory</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Content</td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>