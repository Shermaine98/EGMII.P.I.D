<%-- 
    Document   : DeliveryInvoice
    Created on : 11 4, 15, 10:30:07 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.RepRequestView"%>
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
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/Validation.js"></script>
        <title>Delivery Invoice</title>

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

        <%             ArrayList<RepRequestView> RepRequestView = (ArrayList<RepRequestView>) request.getAttribute("RepRequestViewA");
            if (RepRequestView.size() > 0) {
        %>
        <form id="form1" method="POST" action="ViewDeliveryInvoiceServlet?action=viewSpecificApprove">
            <div class="container" align="center">
                <h2>Inventory Reports</h2><br/>
                <div style="width:60%;">
                    <table id="Replenish" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Report ID</th>
                                <th>Branch Name</th>
                                <th>Promoter</th>
                                <th>Date Made</th>

                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < RepRequestView.size(); i++) {%>
                            <tr class="repView">
                                <td class="reportID"><%=RepRequestView.get(i).getRepID()%></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=RepRequestView.get(i).getBranchName()%>"></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=RepRequestView.get(i).getDateMade()%>"</td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=RepRequestView.get(i).getSupervisor()%>"</td>
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
                        
        <form method="POST" action="EncodeDeliveryInvoiceServlet">
        <%
            String data = (String) request.getAttribute("data");
            if (data.equalsIgnoreCase("viewSpecificApprove")) {
                ArrayList<RepRequestView> RepRequestViewSpecific = (ArrayList<RepRequestView>) request.getAttribute("RepRequestViewSpecA");
                if (RepRequestView.size() > 0) {
                     Integer dirNumber = (Integer) request.getAttribute("dirNumber");
        %>          
        <div class="container" align="center">
            <div class="panel panel-default col-md-3">
                <div class="panel-body">
                    <label for="invoiceNum">Invoice No.</label>
                    <input type="text" class="form-control " readonly name="dirNum" value="<%=dirNumber%>" /><br/>
                    <label for="repID">Replenishment ID</label>
                    <input type="text" class="form-control" readonly name="repID" value="<%=RepRequestViewSpecific.get(0).getRepID()%>" /><br/>
                    <label for="repID">Supervisor</label>
                    <input type="text" class="form-control" readonly name="supervisor" value="<%=RepRequestViewSpecific.get(0).getSupervisor()%>" /><br/>
                    <label for="date">Date Made</label>
                    <input type="text" class="form-control" readonly name="date" value="<%=RepRequestViewSpecific.get(0).getDateMade()%>" /><br/>
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="text" class="form-control" id="datepicker"  name="deliveryDate" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control " readonly name="promo" value="" /><br/>
                    <label for="branch">Branch</label>
                    <input type="hidden" class="form-control" readonly name="location" value="<%=RepRequestViewSpecific.get(0).getLocation()%>" />
                    <input type="text" class="form-control" readonly name="outlet" value="<%=RepRequestViewSpecific.get(0).getBranchName()%>" />
                    <label for="address">Address</label>
                    <input type="text" class="form-control" readonly name="outlet" value="<%=RepRequestViewSpecific.get(0).getAddress()%>" />
                    <input type="hidden" class="form-control" readonly name="madeBy" value="<%=user.getEmployeeNumber()%>" />
                </div>
            </div>
            <div class="panel panel-default col-md-7">
                <br> 
                <h2></h2><br/>
                <div>
                    <h2>Replenishment Request</h2><br/>
                    <table id="data" class="table table-bordered" >
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                for (int i = 0; i < RepRequestViewSpecific.size(); i++) {
                            %>
                            <tr>
                                <td><input type="hidden"  name="itemCode" value="<%=RepRequestViewSpecific.get(i).getProductID()%>"/><%=RepRequestViewSpecific.get(i).getProductName()%></td>
                                <td><%=RepRequestViewSpecific.get(i).getColor()%></td>
                                <td><%=RepRequestViewSpecific.get(i).getSize()%></td>
                                <td><input type="text" name ="qty" value="<%=RepRequestViewSpecific.get(i).getQty()%>"</td>
                            </tr>

                            <%
                                }
                            %>

                        </tbody>
                    </table>
                </div>
                <br>
            </div>


         
            <%
                    }
                }
            %>
        </div>

  <!--Buttons-->
                <<div id="buttonz" align="center">
            <button class="btn btn-default">Approve</button>
            <button class="btn btn-primary">Reject</button><br/><br/>
            <button class="btn btn-default" style="width:130px">Approve & Print</button>
        </div>

</form>
        <script>
            
            
            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });
        </script>

    </body>
</html>
