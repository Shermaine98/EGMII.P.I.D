<%-- 
    Document   : Subcontractor Approval
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.SubconPurchaseOrderView"%>
<%@page import="Model_View.RawMaterialsInventoryView"%>
<%@page import="Model_View.ConsumptionReportView"%>
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
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script src="js/Validation.js"></script>
        <script src="js/Print.js"></script>
        <title>Subcontractor Purchase Order Approval</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
                    var poNumber = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = poNumber;
                    document.getElementById("form1").submit();
                }));

                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

                var x = document.getElementById('trigger').value;
                if (x === "true") {
                    $('input[type="submit').prop('disabled', true);
                }
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
            <strong>Success!</strong> The  Subcontractor Purchase Order is approved!
        </div>
        <%
        } else if (info.equalsIgnoreCase("error")) {
        %>
        <div class="alert alert-danger" style="margin-left : 140px; margin-right: 140px">
            <strong>Oops!</strong> The  Subcontractor Purchase Order is not approve nor rejected! Kindly  screen shot this screen and email/contact the maintenance team and or the developers.
        </div>
        <%
        } else if (info.equalsIgnoreCase("Rejected")) {
        %>
        <div class="alert alert-warning" style="margin-left : 140px; margin-right: 140px">
            <strong>Rejected!</strong> The Subcontractor Purchase Order is  rejected!
        </div>
        <%}%>
        
        <%            int poNumber = 0;
            ArrayList<SubconPurchaseOrderView> ConsumptionReportView = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("PurchaseOrderList");
        %>
        <form id="form1" method="post" action="SetApprovalSubconPOServlet">
            <div class="container" align="center">
                <h2>Approve Subcontractor Purchase Order</h2><br/>
                <div style="">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Purchase Order Number</th>
                                <th>Production Number</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Date Made</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < ConsumptionReportView.size(); i++) {
                                    poNumber = ConsumptionReportView.get(i).getPoNumber();%>
                            <tr class="SubconPO">  
                                <td class="poNumber"><%=ConsumptionReportView.get(i).getPoNumber()%><input type="text" class="transparentBg"/></td>
                                <td><input type="text" name="productionNumber" class="transparentBg" value="<%=ConsumptionReportView.get(i).getProductionNumber()%>" readonly /></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getProductName()%>" readonly /></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getProductType()%>" readonly /></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getDateMade()%>" readonly /></td>
                                <td><input type="hidden" class="transparentBg" value="<%=ConsumptionReportView.get(i).getPreparedBy()%>" /><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getPreparedByName()%>" readonly /></td>

                            </tr> 
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </form>
        <br/>

        <%
            String data = (String) request.getAttribute("data");
            if (data.equalsIgnoreCase("subconApproval")) {
                ArrayList<ConsumptionReportView> productSizes = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforSizes");
                ArrayList<SubconPurchaseOrderView> crHeader = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("CRHeader");

        %>
        <form method="POST" action="ApproveRejectSubconPOServlet?action=approve">
            <div class="container" align="center" id="printableArea">
                <!--view header-->
                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control" readonly name="poNumber" value ="<%=crHeader.get(0).getPoNumber()%>" /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control" readonly name="preparedBy" value="<%=crHeader.get(0).getPreparedByName()%>"/><br/>
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" class="form-control " readonly name="deliveryDate" value="<%=crHeader.get(0).getDeliveryDate()%>"/><br/>
                        <label for="supplier">Subcontractor</label>
                         <input type="text" class="form-control " readonly name="subcon" value="<%=crHeader.get(0).getSubconID()%>"/><br/>
                        <input type="text" class="form-control " readonly value="<%=crHeader.get(0).getCompanyName()%>"/><br/>
                        <label for="productionNumber">Production Number</label>
                        <input type="text" class="form-control " readonly name="productionNumber" value="<%=crHeader.get(0).getProductionNumber()%>"/><br/>
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control " readonly name="productName" value="<%=crHeader.get(0).getProductName()%>"/><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" class="form-control " readonly name="productType" value="<%=crHeader.get(0).getProductType()%>"/><br/>
                        <label for="color">Color</label>
                        <input type="text" class="form-control " readonly name="color" value="<%=crHeader.get(0).getProductColor()%>"/><br/>

                        <input type="text" class="hidden" readonly name="employeeNumber" value="<%=user.getEmployeeNumber()%>"/>
                    </div>
                </div>
                <!--end header-->

                <div class="panel panel-default col-md-7" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered">
                            <tr>
                                <%                                for (int i = 0; i < productSizes.size(); i++) {
                                %>
                                <th><input name="sizeType" class="transparentBg readonlyWhite inputSize" value="<%=productSizes.get(i).getSize()%>" readonly/></th>
                                    <%
                                        }
                                    %>
                                <th>Total</th></tr>
                            <tr>
                                <%
                                    double total = 0;
                                    for (int i = 0; i < productSizes.size(); i++) {

                                %>
                                <td><input type="text" readonly class="transparentBg inputSize" name="volumeQty" id="sizeS" value="<%=productSizes.get(i).getVolumeQty()%>" /></td>
                                    <%
                                            total += productSizes.get(i).getVolumeQty();
                                        }
                                    %>  
                                <td><input name="TotalS" class="transparentBg inputSize" id="TotalS" value="<%=total%>" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>
            <div align="center">
                <!--Buttons-->
                <input type="submit" value="Approve" class="btn btn-danger" />
            </div>
        </form>
        <form method="POST" action="ApproveRejectSubconPOServlet?action=reject">
            <div align="center">
                <input type="hidden" name="rPoNumber" value="<%=poNumber%>" /><br/>
                <button class="btn btn-primary">Reject</button>
            </div>
        </form><br/>
        <div align="center"> 
                <button class="btn btn-default" onclick="printDiv('printableArea')">Print</button>
        </div>
        <% }%>
    </body>
</html>
