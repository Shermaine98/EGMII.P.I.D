<%-- 
    Document   : ViewConsumptionReport
    Created on : 10 1, 15, 12:10:28 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="Model.ConsumptionReport"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/table-design.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <title>View Consumption Report</title>
        <script>
            $(document).ready(function () {
                $('#view').DataTable({
                    "paging": true,
                    "info": true
//                    "dom": '<"pull-left "f>'
                });

                $(".production").on("click", (function () {
                    var productionNumber = $(this).closest("tr").find(".productionNumber").text();
                    document.getElementById('hiddenValue').value = productionNumber;
                    document.getElementById("form1").submit();
                }));
            });
        </script>    

    </head>
    <body>

        <% String data = (String) request.getAttribute("data");
            ArrayList<ConsumptionReportView> cr = (ArrayList<ConsumptionReportView>) request.getAttribute("crList"); %>
        <!--View Consumption Report-->
        <form id="form1" method="post" action="ViewConsumptionReportServlet">
            <div class="col-md-8 center1" align="center">
                <h2>View Consumption Report</h2>
                <br/>
                <table id="view" class="table table-bordered table-hover dataTable">
                    <thead>
                        <tr>
                            <th>Production No.</th>
                            <th>Product Name</th>
                            <th>Product Type</th>
                            <th>Date Made</th>
                            <th>Color</th>
                            <th>Prepared By</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            for (int i = 0; i < cr.size(); i++) {
                        %>
                        <tr class="production">
                            <td class="productionNumber"><%= cr.get(i).getProductionNumber()%></td>
                            <td><%= cr.get(i).getProductName()%></td>
                            <td><%= cr.get(i).getProductType()%></td>
                            <td><%= cr.get(i).getDateMade()%></td>
                            <td><%= cr.get(i).getColor()%></td>
                            <td><%= cr.get(i).getName()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
        </form> 
        <br/><br/>
        <%
            if (data.equalsIgnoreCase("ViewConsumptionReportSpecific")) {
                ArrayList<ConsumptionReportView> cr1 = (ArrayList<ConsumptionReportView>) request.getAttribute("crListSpecific");

        %>
        <!-- To get the Click row-->
        <div class="panel panel-default col-md-6" style="margin-left:190px; margin-right:190px; margin-bottom: 30px;">
            <div class="panel-body" id="consumptionReportList">

                <h3>Consumption Report Details</h3>
                <!--Consumption Report View From Encode of Bill of Materials-->
                <h4><b>Production Number: </b>
                    <%= cr1.get(0).getProductionNumber()%>
                    <br/>
                    <b>Product Name:</b>
                    <%= cr1.get(0).getProductName()%>
                    <br/>
                    <b>Product Type:</b>
                    <%= cr1.get(0).getProductType()%>
                    <br/>
                    <b>Date Made:</b>
                    <%= cr1.get(0).getDateMade()%>
                    <br/>
                    <b>Color:</b>
                    <%= cr1.get(0).getColor()%>
                    <br/>
                    <b>Prepared By:</b>
                    <%= cr1.get(0).getName()%>
                </h4>
                <br/>
                <form method="POST" action="PrintConsumptionReport" target="_blank">
                    <input type="hidden" id="printPONumber" name="printPONumber" value="<%= cr1.get(0).getProductionNumber()%>"/>
                    <input type="submit" class="btn btn-default" value="Print" />
                </form>
            </div>
        </div>
        <%
            }
        %>
        <input type="hidden" name="productionNumber" id="hiddenValue" value=""/>
    </div>

</body>
</html>
