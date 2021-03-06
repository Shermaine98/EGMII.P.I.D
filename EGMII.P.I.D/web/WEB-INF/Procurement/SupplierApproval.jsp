<%-- 
    Document   : Supplier Approval
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>
<%@page import="Model_View.SupplierPurchaseOrderView"%>
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
        <script src="js/searchSupplier.js"></script>
        <script src="js/Validation.js"></script>
        <script src="js/Print.js"></script>
        <title>Supplier Purchase Order Approval</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));

            });


        </script>
    </head>
    <%        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderList");
    %>
    <body>

        <!--Alert-->
        <%
            String info = (String) request.getAttribute("info");
            if (info.equalsIgnoreCase("success")) {
        %>
        <div class="alert alert-success" style="margin-left : 140px; margin-right: 140px">
            <strong>Success!</strong> The  Supplier Purchase Order is approved!
        </div>
        <%
        } else if (info.equalsIgnoreCase("error")) {
        %>
        <div class="alert alert-danger" style="margin-left : 140px; margin-right: 140px">
            <strong>Oops!</strong> The  Supplier Purchase Order is not approve nor rejected! Kindly  screen shot this screen and email/contact the maintenance team and or the developers.
        </div>
        <%
        } else if (info.equalsIgnoreCase("Rejected")) {
        %>
        <div class="alert alert-warning" style="margin-left : 140px; margin-right: 140px">
            <strong>Rejected!</strong> The Supplier Purchase Order is  rejected!
        </div>
        <%}%>
        <form id="form1" method="POST" action="SetApprovalSupplierPO">
            <div class="container" align="center">
                <h2>Approve Supplier Purchase Order</h2><br/>
                <div style="width: 80%">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Purchase Order No.</th>
                                <th>Supplier</th>
                                <th>Date Made</th>
                                <th>Delivery Date</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < PurchaseOrderList.size(); i++) {%>
                            <tr>
                                <td class="poNumber"><%=PurchaseOrderList.get(i).getPoNumber()%><input type="text" readonly class="transparentBg"/></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=PurchaseOrderList.get(i).getCompanyName()%>"/></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=PurchaseOrderList.get(i).getDateMade()%>"/></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=PurchaseOrderList.get(i).getDeliveryDate()%>"/></td>
                                <td><input type="hidden" class="transparentBg" value="<%=PurchaseOrderList.get(i).getPreparedBy()%>"/><input type="text" class="transparentBg" value="<%=PurchaseOrderList.get(i).getName()%>"/></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </form>
        <br/><br/>
        <%
            String data = (String) request.getAttribute("data");
            if (data.equalsIgnoreCase("supplier")) {
                ArrayList<SupplierPurchaseOrderView> PurchaseOrderSpecific = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderSpecific");
                if (!PurchaseOrderSpecific.isEmpty()) {
                    double total = 0;
        %>
        <form method="POST" action="ApproveRejectSPOServlet?action=approve">
            <div class="container" align="center" id="printableArea">
                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control" readonly name="poNumber" value ="<%=PurchaseOrderSpecific.get(0).getPoNumber()%>" /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="hidden" class="form-control" value="<%=PurchaseOrderSpecific.get(0).getPreparedBy()%>"/><br/>
                        <input type="text" class="form-control" readonly name="preparedBy" value="<%=PurchaseOrderSpecific.get(0).getName()%>"/><br/>
                        <label for="dateMade">Date Made</label>
                        <input type="text" class="form-control " readonly name="dateMade" value="<%=PurchaseOrderSpecific.get(0).getDateMade()%>"/><br/>
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" class="form-control " readonly name="deliveryDate" value="<%=PurchaseOrderSpecific.get(0).getDeliveryDate()%>"/><br/>
                        <label for="supplier">Supplier</label>
                        <input type="text" class="form-control " readonly name="supplier" value="<%=PurchaseOrderSpecific.get(0).getCompanyName()%>"/><br/>
                        <input type="text" class="hidden" readonly name="employeeNumber" value="<%=user.getEmployeeNumber()%>"/>
                    </div>
                </div>
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Details</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <colgroup>
                                <col style="width: 40%" />
                            </colgroup>
                            <tr>
                                <th>Item Name</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                            </tr>
                            <%for (int x = 0; x < PurchaseOrderSpecific.size(); x++) {%>
                            <tr class="trclass">
                                <td><%=PurchaseOrderSpecific.get(x).getItemName()%></td>
                                <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly value ="<%=PurchaseOrderSpecific.get(x).getUnitPrice()%>" id="unitPrice[]"/></td>
                                <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly value="<%=PurchaseOrderSpecific.get(x).getQty()%>" id="volumeQty[]"/></td>
                                <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly value="<%=PurchaseOrderSpecific.get(x).getQty() * PurchaseOrderSpecific.get(x).getUnitPrice()%>"id="TQP[]"/></td>   
                            </tr>
                            <%
                                    total += PurchaseOrderSpecific.get(x).getQty() * PurchaseOrderSpecific.get(x).getUnitPrice();

                                }%>
                        </table>

                        <div id="run" class="form-inline pull-right">
                            <label for="total">Total:</label>
                            <input type="number" class="form-control readonlyWhite" name="total" value="<%= total%>" id="total" readonly /> 
                        </div>
                    </div>
                </div>
            </div>
            <div id="buttonz" align="center">
                <!--Buttons-->
                <input type="submit" value="Approve" class="btn btn-danger" />
            </div>
        </form> <br/>
        <form method="POST" action="ApproveRejectSPOServlet?action=reject">
            <div align="center">
                <input type="hidden" name="poNumber" value="<%=PurchaseOrderSpecific.get(0).getPoNumber()%>" />
                <button class="btn btn-primary">Reject</button>
            </div>
        </form><br/>
        <div align="center">
            <button class="btn btn-default" onclick="printDiv('printableArea')">Print</button>
        </div>

        <%
                }
            }%>

    </body>
</html>
