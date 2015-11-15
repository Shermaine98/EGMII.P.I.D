<%-- 
    Document   : Boutique Inventory
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.RetailInventoryView"%>
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
        <title>Boutique Inventory</title>
        <script>
            $(document).ready(function () {
                $('#BoutiqueInventory').DataTable({
                    "paging": true,
                    "info": true
                });
                $('#BoutiqueInventory2').DataTable({
                    "paging": true,
                    "info": true
                });
            });
        </script>
    </head>
    <body>  
        <%        ArrayList<RetailInventoryView> retailInventory = (ArrayList<RetailInventoryView>) request.getAttribute("RBIList");
        %>
        <div align="center" class="container">
            <h2>Boutique Inventory</h2>
            <table id="BoutiqueInventory" class="table table-bordered">
                <thead>
                    <tr>
                        <th>Branch Name</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Product Type</th>
                        <th>Color</th>
                        <th>Size</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < retailInventory.size(); i++) {
                            if (retailInventory.get(i).getQty() > 0) {
                    %>
                    <tr>
                        <td><%=retailInventory.get(i).getBranchName()%></td>
                        <td><%=retailInventory.get(i).getItemCode()%></td>
                        <td><%=retailInventory.get(i).getProductName()%></td>
                        <td><%=retailInventory.get(i).getProductType()%></td>
                        <td><%=retailInventory.get(i).getColor()%></td>
                        <td><%=retailInventory.get(i).getSize()%></td>
                        <td><%=retailInventory.get(i).getQty()%></td>
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
            <table id="BoutiqueInventory2" class="table table-bordered">
                <thead>
                    <tr>
                        <th>Branch Name</th>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Product Type</th>
                        <th>Color</th>
                        <th>Size</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < retailInventory.size(); i++) {
                            if (retailInventory.get(i).getQty() <= 0) {
                    %>
                    <tr>
                        <td><%=retailInventory.get(i).getBranchName()%></td>
                        <td><%=retailInventory.get(i).getItemCode()%></td>
                        <td><%=retailInventory.get(i).getProductName()%></td>
                        <td><%=retailInventory.get(i).getProductType()%></td>
                        <td><%=retailInventory.get(i).getColor()%></td>
                        <td><%=retailInventory.get(i).getSize()%></td>
                        <td><%=retailInventory.get(i).getQty()%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <form method="POST" action="PrintBoutiqueInventory" target="_blank">
            <div align="center">
                <input type="submit" class="btn btn-default" value="Save"/>
            </div>
        </form>
    </body>
</html>
