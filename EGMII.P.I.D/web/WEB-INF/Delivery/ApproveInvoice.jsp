<%-- 
    Document   : Approve Invoice
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.DeliveryInvoiceView"%>
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
                    var diNumber = $(this).closest("tr").find(".diNumber").text();
                    document.getElementById('hiddenValue').value = diNumber;
                    document.getElementById("form1").submit();
                }));
            });
        </script>
    </head>
    <body>

        <%  int dNum = 0;
            ArrayList<DeliveryInvoiceView> DeliveryInvoiceView = (ArrayList<DeliveryInvoiceView>) request.getAttribute("DeliveryInvoiceViewA");
            if (DeliveryInvoiceView.size() > 0) {
        %>
        <form id="form1" method="POST" action="ViewDeliveryInvoiceServlet?action=viewSpecificApprove">
            <div class="container" align="center">
                <h2>Choose Delivery Invoice To Approve</h2><br/>
                <div style="width:80%;">
                    <table id="Replenish" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Delivery Invoice Number</th>
                                <th>Branch Name</th>
                                <th>Made by</th>
                                <th>Delivery Date</th>
                                <th>Date Made</th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (int i = 0; i < DeliveryInvoiceView.size(); i++) {
                                    dNum = DeliveryInvoiceView.get(0).getDiNumber();%>
                            <tr class="repView">
                                <td class="diNumber"><%=DeliveryInvoiceView.get(i).getDiNumber()%></td>
                                <td><input type="text" readonly class="transparentBg " value="<%=DeliveryInvoiceView.get(i).getBranchName()%>"></td>
                                <td><input type="text" readonly class="transparentBg " value="<%=DeliveryInvoiceView.get(i).getName()%>" /></td>
                                <td><input type="text" readonly class="transparentBg " value="<%=DeliveryInvoiceView.get(i).getDeliveryDate()%>" /></td>
                                <td><input type="text" readonly class="transparentBg " value="<%=DeliveryInvoiceView.get(i).getDateMade()%>" /></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="diNumber" id="hiddenValue" value=""/>
            </div>
        </form>

        <form method="POST" action="ApproveDeliveryInvoiceSerlvet?action=approve">
            <%
                String data = (String) request.getAttribute("data");
                if (data.equalsIgnoreCase("viewSpecificApprove")) {
                    ArrayList<DeliveryInvoiceView> DeliveryInvoiceS = (ArrayList<DeliveryInvoiceView>) request.getAttribute("DeliveryInvoiceViewSpecA");

                    if (DeliveryInvoiceS.size() > 0) {
            %>          
            <div class="container" align="center">
                <div class="panel panel-default col-md-3">
                    <div class="panel-body">
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" class="form-control" readonly   name="deliveryDate" value="<%=DeliveryInvoiceS.get(0).getDeliveryDate()%>" /><br/>
                        <label for="invoiceNum">Invoice No.</label>
                        <input type="text" class="form-control " readonly name="diNumber" value="<%=DeliveryInvoiceView.get(0).getDiNumber()%>" /><br/>
                        <label for="date">Date Made</label>
                        <input type="text" class="form-control" readonly name="date" value="<%=DeliveryInvoiceS.get(0).getDateMade()%>" /><br/>
                        <label for="branch">Branch</label>
                        <input type="hidden" class="form-control" name="location" value="<%=DeliveryInvoiceS.get(0).getLocationID()%>" /><br/>
                        <input type="text" class="form-control" readonly name="outlet" value="<%=DeliveryInvoiceS.get(0).getBranchName()%>" /><br/>
                        <label for="address">Address</label>
                        <input type="text" class="form-control" readonly name="outlet" value="<%=DeliveryInvoiceS.get(0).getAddress()%>" />
                        <input type="hidden" class="form-control" name="approvedBy" value="<%=user.getEmployeeNumber()%>" />
                    </div>
                </div>
                <div class="panel panel-default col-md-7">
                    <div>
                        <h2>Delivery Invoice</h2><br/>
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
                                    for (int i = 0; i < DeliveryInvoiceS.size(); i++) {
                                %>
                                <tr>
                                    <td><input type="hidden" name="itemCode" value="<%=DeliveryInvoiceS.get(i).getProductID()%>"/><%=DeliveryInvoiceS.get(i).getProductName()%></td>
                                    <td><%=DeliveryInvoiceS.get(i).getColor()%></td>
                                    <td><%=DeliveryInvoiceS.get(i).getSize()%></td>
                                    <td><input type="text" class="readonlyWhite transparentBg" readonly name ="qty" value="<%=DeliveryInvoiceS.get(i).getQty()%>" /></td>
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
            <div id="buttonz" align="center">
                <button class="btn btn-danger">Approve</button>
                <button class="btn btn-default" style="width:130px">Approve & Print</button>
            </div>
        </form>
        <form method="POST" action="ApproveDeliveryInvoiceSerlvet?action=reject">
            <div align="center">
                <input type="hidden" name="diNumber" value="<%=dNum%>" /><br/>
                <button class="btn btn-primary">Reject</button>
            </div>
        </form>

        <%
                }
            }
        %>
        <script>


            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });
        </script>

    </body>
</html>
