<%-- 
    Document   : Delivery Invoice
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
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
        <!--Alert-->
        <%  
            String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
        %>
        <div class="alert alert-success" style="margin-left : 140px; margin-right: 140px">
            <strong>Success!</strong> The  Delivery Invoice is created!
        </div>
        <%
        } else if (info.equalsIgnoreCase("error")) {
        %>
        <div class="alert alert-danger" style="margin-left : 140px; margin-right: 140px">
            <strong>Oops!</strong> Something went wrong! Kindly  screen shot this screen and email/contact the maintenance team and or the developers.
        </div>
        <%
        }
        %>
        <%             ArrayList<RepRequestView> RepRequestView = (ArrayList<RepRequestView>) request.getAttribute("RepRequestView");
            if (RepRequestView.size() > 0) {
        %>
        <form id="form1" method="POST" action="ViewDeliveryInvoiceServlet?action=viewSpecific">
            <div class="container" align="center">
                <h2>Choose Replenishment Reports</h2><br/>
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
                                <td><input type="text" readonly class="transparentBg" value="<%=RepRequestView.get(i).getBranchName()%>"></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=RepRequestView.get(i).getDateMade()%>" /></td>
                                <td><input type="text" readonly class="transparentBg inputSize" value="<%=RepRequestView.get(i).getSupervisorName()%>" /></td>
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
                if (data.equalsIgnoreCase("viewSpecific")) {
                    ArrayList<RepRequestView> RepRequestViewSpecific = (ArrayList<RepRequestView>) request.getAttribute("RepRequestViewSpec");
                    if (RepRequestView.size() > 0) {
                        Integer dirNumber = (Integer) request.getAttribute("dirNumber");
            %>          
            <div class="container" align="center">
                <div class="panel panel-default col-md-3">
                    <div class="panel-body">
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" placeholder="yyyy-mm-dd" class="form-control" id="datepicker" pattern=".{1,}" required title="Please Input Delivery Date" /><br/>
                        <label for="invoiceNum">Invoice No.</label>
                        <input type="text" class="form-control " readonly name="dirNum" value="<%=dirNumber%>" /><br/>
                        <label for="repID">Replenishment ID</label>
                        <input type="text" class="form-control" readonly name="repID" value="<%=RepRequestViewSpecific.get(0).getRepID()%>" /><br/>
                        <label for="repID">Supervisor</label>
                        <input type="hidden" class="form-control" readonly name="supervisor" value="<%=RepRequestViewSpecific.get(0).getSupervisor()%>" /><br/>
                        <input type="text" class="form-control" readonly name="supervisor" value="<%=RepRequestViewSpecific.get(0).getSupervisorName()%>" /><br/>
                        <label for="date">Date Made</label>
                        <input type="text" class="form-control" readonly name="date" value="<%=RepRequestViewSpecific.get(0).getDateMade()%>" /><br/>
                        <label for="branch">Branch</label>
                        <input type="hidden" class="form-control"  name="location" value="<%=RepRequestViewSpecific.get(0).getLocation()%>" />
                        <input type="text" class="form-control" readonly name="outlet" value="<%=RepRequestViewSpecific.get(0).getBranchName()%>" />
                        <label for="address">Address</label>
                        <input type="text" class="form-control" readonly name="outlet" value="<%=RepRequestViewSpecific.get(0).getAddress()%>" />
                        <input type="hidden" class="form-control" name="madeBy" value="<%=user.getEmployeeNumber()%>" />
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
                                    <td><input type="text" class="readonlyWhite transparentBg inputSize" readonly name ="qty" value="<%=RepRequestViewSpecific.get(i).getQty()%>" /></td>
                                </tr>

                                <%
                                    }
                                %>

                            </tbody>
                        </table>
                    </div>
                    <br>
                </div>
            </div>
            <!--Buttons-->
            <div id="buttonz" align="center" >
                <input type="submit" class="btn btn-danger" value="Submit"/>
            </div>

            <%
                    }
                }
            %>




        </form>
        <script>


            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });
        </script>

    </body>
</html>
