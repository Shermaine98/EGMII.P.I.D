<%-- 
    Document   : View Replenishment Request
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="DAO.UserDAO"%>
<%@page import="Model_View.RepRequestView"%>
<%@page import="Model_View.WarehouseInventoryView"%>
<%@page import="Model.InventoryReportCom"%>
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
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/Validation.js"></script>
        <title>Replenishment Request</title>
        <style>
        </style>
        <script>
            $(document).ready(function () {
                $('#Replenish').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#Replenish tbody").on("click", 'input[type="text"]', (function () {
                    var reportID = $(this).closest("tr").find(".reportID").text();
                    document.getElementById('hiddenValue').value = reportID;
                    document.getElementById("form1").submit();
                }));
            });



        </script>
    </head>
    <body>

        <%   
            ArrayList<RepRequestView> RepRequestView = (ArrayList<RepRequestView>) request.getAttribute("RepRequestView");
            if (RepRequestView.size() > 0) {
        %>
        <form id="form1" method="POST" action="ViewReplenishmentServlet?action=viewSpecific">
        <div class="container" align="center">
            <h2>Replenishment Request</h2><br/>
            <div style="width:60%;">
                <table id="Replenish" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Report ID</th>
                            <th>Branch Name</th>
                             <th>Date Made</th>
                            <th>Prepared By</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < RepRequestView.size(); i++) {%>
                        <tr class="repView">
                            <td class="reportID"><%=RepRequestView.get(i).getRepID()%></td>
                            <td><input type="text" class="transparentBg " value="<%=RepRequestView.get(i).getBranchName()%>" readonly /></td>
                            <td><input type="text" class="transparentBg " value="<%=RepRequestView.get(i).getDateMade()%>" readonly /></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=RepRequestView.get(i).getSupervisorName()%>" readonly /></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="reportID" id="hiddenValue" value=""/>
        </div>
       </form>
           <%   
            
            String data = (String) request.getAttribute("data");
                if (data.equalsIgnoreCase("viewSpecific")) {
            ArrayList<RepRequestView> RepRequestViewSpecific = (ArrayList<RepRequestView>) request.getAttribute("RepRequestViewSpec");
                if (RepRequestView.size() > 0) {
        %>          
        <br/><br/>  
        <div class="container" align="center">
            
                <div class="panel panel-default col-md-3">

                    <div class="panel-body">
                        <label for="outlet">Outlet</label>
                        <input type="text" class="form-control" readonly name="outlet" value="<%=RepRequestViewSpecific.get(0).getBranchName()%>" /><br/>
                        <label for="date">Date Made</label>
                        <input type="text" class="form-control" readonly name="date" value="<%=RepRequestViewSpecific.get(0).getDateMade()%>" /><br/>
                        <label for="repID">Replenishment ID</label>
                        <input type="text" class="form-control" readonly name="repID" value="<%=RepRequestViewSpecific.get(0).getRepID()%>" /><br/>
                        <label for="Supervisor">Supervisor</label>
                        <input type="text" class="form-control" readonly name="supervisor" value="<%=RepRequestViewSpecific.get(0).getSupervisorName()%>" /><br/>
                        
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <div>
                        <h2>Replenishment Request</h2><br/>
                        <table id="data" class="table table-bordered" >
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Color</th>
                                    <th>Size</th>
                                    <th>Requested Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                <%
                                for(int i=0; i<RepRequestViewSpecific.size(); i++){
                                %>
                                <tr>
                                 <td><%=RepRequestViewSpecific.get(i).getProductName()%></td>
                                 <td><%=RepRequestViewSpecific.get(i).getColor()%></td>
                                 <td><%=RepRequestViewSpecific.get(i).getSize()%></td>
                                 <td><%=RepRequestViewSpecific.get(i).getQty()%></td>
                                </tr>
                                 
                                <%
                                }
                                %>

                            </tbody>
                        </table>
                    </div>
                    <br>
                </div>


                <!--Buttons-->
                <div id="buttonz" align="center" style="visibility: hidden">
                    <input type="submit" class="btn btn-default" value="SUBMIT"/>
                </div>


                <%
                    }
                }
                %>
                
                
        </div>
    </body>
</html>
