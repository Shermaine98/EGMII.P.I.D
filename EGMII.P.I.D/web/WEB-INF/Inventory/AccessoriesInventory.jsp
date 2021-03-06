<%-- 
    Document   : Accessories Inventory
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
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
        <script src="js/Validation.js"></script>
        <title>Accessories Inventory</title>
        <script>
            $(document).ready(function () {
                $('#AccessoriesInventory').DataTable({
                    "paging": true,
                    "info": true
                });

                $('#AccessoriesInventory2').DataTable({
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
                <table id="AccessoriesInventory" class="table table-bordered">
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
                                if (AccessoriesInventory.get(i).getQty() > 0) {
                        %>
                        <tr>
                            <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                            <td><%=AccessoriesInventory.get(i).getItemName()%></td>
                            <td><%=AccessoriesInventory.get(i).getQty()%></td>
                            <td><%=AccessoriesInventory.get(i).getUnitMeasurement()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <!-- for 0 qty -->
            <br/><br/>
            <h3>Out of Stock</h3>
            <div>
                <table id="AccessoriesInventory2" class="table table-bordered">
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
                                if (AccessoriesInventory.get(i).getQty() <= 0) {
                        %>
                        <tr>
                            <td><%=AccessoriesInventory.get(i).getItemCode()%></td>
                            <td><%=AccessoriesInventory.get(i).getItemName()%></td>
                            <td><%=AccessoriesInventory.get(i).getQty()%></td>
                            <td><%=AccessoriesInventory.get(i).getUnitMeasurement()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <form method="POST" action="PrintAccessoriesInventory" target="_blank">
            <div align="center">
                <input type="submit" class="btn btn-default" value="Save"/>
            </div>
        </form>
    </body>
</html>
