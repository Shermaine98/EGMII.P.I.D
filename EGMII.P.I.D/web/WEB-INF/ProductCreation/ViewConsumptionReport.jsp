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
        <div class="col-md-8 center1">
            <h2>View Consumption Report</h2>
            <br/><br/><br/>  
            <table id="view" class="table table-striped table-bordered table-hover table-responsive dataTable">
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
                
            <br/><br/>
            <!-- To get the Click row-->
            <div class="panel panel-default" style="margin-left:70px; margin-right:70px;">
                <div class="panel-body" id="consumptionReportList">
                </div>
            </div>
             <input type="hidden" name="productionNumber" id="hiddenValue" value=""/>
        </div>
       </form>      
        <br/><br/>
        <div>
        <%
         if (data.equalsIgnoreCase("ViewConsumptionReportSpecific")) {
            ArrayList<ConsumptionReportView> cr1 = (ArrayList<ConsumptionReportView>) request.getAttribute("crListSpecific");

        %>
        <!--Consumption Report View From Encode of Bill of Materials-->

        <table><td><%= cr1.get(0).getProductionNumber()%></td></table>
                <%
                    }
                %>
                <br/><br/>
        </div>
    </body>
</html>
