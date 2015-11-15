<%-- 
    Document   : View Inventory Report
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.InventoryReportView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/Validation.js"></script>
        <title>View Inventory Report</title>
    </head>
    <body>
        <%            ArrayList<InventoryReportView> InventoryReportView = (ArrayList<InventoryReportView>) request.getAttribute("InventoryReportList");
            if (!InventoryReportView.isEmpty()) {

        %>      
        <div class="container" align="center">

            <h2>View Inventory Report</h2>

            <div class="panel panel-default col-md-4 pull-left" style="padding-bottom:10px;">
                <div class="panel-heading">
                    <h3 class="panel-title">Inventory Report</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Outlet</th>
                            <th>Promo</th>
                            <th>Date</th>
                        </tr>
                        <tr>
                            <td><%=InventoryReportView.get(0).getBranchName()%></td>
                            <td><%=InventoryReportView.get(0).getPromo()%></td>
                            <td><%=InventoryReportView.get(0).getDateMade()%></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="panel panel-collapse col-md-6" style="padding-bottom: 10px; margin-top:20px;">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width:30%" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Beginning Inventory</th>
                                <th>Pulled Out</th>
                                <th>Sold Out</th>
                                <th>Ending Inventory</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < InventoryReportView.size(); i++) {%>
                            <tr class="trclass">
                                <td><%=InventoryReportView.get(i).getProductName()%></td>
                                <td><%=InventoryReportView.get(i).getColor()%></td>
                                <td><%=InventoryReportView.get(i).getSize()%></td>
                                <td><%= InventoryReportView.get(i).getQty() + (InventoryReportView.get(i).getPulledOutQty() + InventoryReportView.get(i).getSoldQty())%></td>
                                <td><%=InventoryReportView.get(i).getPulledOutQty()%></td>
                                <td><%=InventoryReportView.get(i).getSoldQty()%></td>
                                <td><%=InventoryReportView.get(i).getQty()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>
        <!--Buttons-->

        <form method="POST" action="PrintInventoryReport" target="_blank">
            <div align="center">
                <input type="submit" class="btn btn-danger" value="Save"  />
            </div>
        </form><br/>
        <div id="buttonz" align="center">
            <button class="btn btn-danger" style="width:130px">Create Request</button>
        </div>
        <%}%>
    </body>
</html>
