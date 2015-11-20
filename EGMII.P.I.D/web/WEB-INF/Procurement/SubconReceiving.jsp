<%-- 
    Document   : SupplierReceiving
    Created on : 11 4, 15, 1:43:12 PM
    Author     : Geraldine
--%>

<%@page import="Model.ConsumptionReportDetails"%>
<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="Model_View.SubconPurchaseOrderView"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Receiving</title>

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
                
                $(".trclass").on("keyup", (function () {
                    var volumeQty = parseInt($(this).closest("tr").find(".volumeQty").text());
                    var deliveredQty = parseInt($(this).closest("tr").find(".deliveredQty").text());
                    var receivedQty = parseInt($(this).closest("tr").find('[id="receivedqty\\[\\]"]').val());

                    if (receivedQty !== 0) {
                        
                        var remainingTotal = volumeQty - deliveredQty;
                        if (remainingTotal < receivedQty) {
                            window.alert("Quantity exceeds possible receiving quantity");
                            $(this).closest("tr").find('[id="receivedqty\\[\\]"]').val(0);
                        } /* else if (remainingTotal <= receivedQty) {
                            window.alert("WRONG");
                            $(this).closest("tr").find('[id="receivedqty\\[\\]"]').val(0);
                        } */
                    }

                }));

                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

                var x = document.getElementById('trigger').value;
                if (x === "true") {
                    $('input[type="submit').prop('disabled', true);
                }
            });
        </script>
        <style>
            .numericControl{
                width:100%;
            }
        </style>
    </head>
    <body>
        <form id="form1" method="post" action="SetSubconPOReceivingServlet?action=viewSpecific">
            <br/>
            <center><h2>Subcontractor Purchase Order Receiving</h2></center>

            <br/><br/>
            <%            ArrayList<SubconPurchaseOrderView> ConsumptionReportView = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("SubconPOApproved");
            %>
            <div class="container" align="center">
                <div style="width:70%;">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Purchase Order Number</th>
                                <th>Production Number</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Date Made</th>
                                <th>Prepared By</th>
                                 <th>Approved By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < ConsumptionReportView.size(); i++) {%>
                            <tr class="SubconPO">  
                                <td class="poNumber"><%=ConsumptionReportView.get(i).getPoNumber()%><input type="text" readonly class="transparentBg inputSize"/></td>
                                <td><input type="text" name="productionNumber" readonly class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductionNumber()%>"/></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=ConsumptionReportView.get(i).getProductName()%>"/></td>
                                <td><input type="text" readonly class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductType()%>"/></td>
                                <td><input type="text" readonly class="transparentBg" value="<%=ConsumptionReportView.get(i).getDateMade()%>"/></td>
                                <td><input type="text" readonly class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getPreparedByName()%>"/></td>
                                <td><input type="text" readonly class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getApprovedByName()%>"/></td>
                            </tr> 
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </form>

        <%
            String data = (String) request.getAttribute("data");
            if (data.equalsIgnoreCase("subconApproval")) {
                ArrayList<ConsumptionReportView> productSizes = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforSizesA");
                ArrayList<SubconPurchaseOrderView> crHeader = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("CRHeaderA");
                ArrayList<ConsumptionReportDetails> delQty = (ArrayList<ConsumptionReportDetails>) request.getAttribute("CRdelivered");

        %>

        <br/><br/>
        <form method="post" action="EncodeSubconDRServlet">
            <div class="container" align="center">
                <!--Start Header-->
                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control" readonly name="poNumber" value ="<%=crHeader.get(0).getPoNumber()%>" /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control" readonly name="preparedBy" value="<%=crHeader.get(0).getPreparedByName()%>"/><br/>
                        <label for="preparedBy">Received By</label>
                        <input type="hidden" class="form-control " name="receivedBy" value="<%=user.getEmployeeNumber()%>" /><br/>
                        <input type="text" class="form-control " readonly  value="<%=user.getFirstName()%> <%=user.getLastName()%>" /><br/>
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" class="form-control " readonly name="deliveryDate" value="<%=crHeader.get(0).getDeliveryDate()%>"/><br/>
                        <label for="supplier">Subcontractor</label>
                        <input type="hidden" class="form-control " readonly name="subcon" value="<%=crHeader.get(0).getSubconID()%>"/><br/>
                        <input type="text" class="form-control " readonly value="<%=crHeader.get(0).getCompanyName()%>"/><br/>
                        <label for="productionNumber">Production Number</label>
                        <input type="text" class="form-control " readonly name="productionNumber" value="<%=crHeader.get(0).getProductionNumber()%>"/><br/>
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control " readonly name="productName" value="<%=crHeader.get(0).getProductName()%>"/><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" class="form-control " readonly name="productType" value="<%=crHeader.get(0).getProductType()%>"/><br/>
                        <label for="color">Color</label>
                        <input type="text" class="form-control " readonly name="color" value="<%=crHeader.get(0).getProductColor()%>"/><br/>
                      
                    </div>
                </div>
                <!--End Header-->

                <!--start delivery receipt-->
                <div class="form-inline">
                    <label for="drNumber">Delivery Receipt Number</label>
                    <input type="text" class="form-control" name="drNumber" pattern=".{2,}" required title="Please Input Delivery Receipt Number." />
                </div>
                <!--end delivery receipt-->

                <!--Start Sizes-->
                <div class="panel panel-default col-md-6" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered">
                            <thead>
                            <th>Sizes</th>
                            <th>Quantity</th>
                            <th>Delivered Quantity</th>
                            <th>Received</th>
                            </thead>
                            <%
                              
                                for (int i = 0; i < productSizes.size(); i++) {

                            %>
                            <tr class="trclass">
                                <td><input name="sizeType" class="transparentBg readonlyWhite inputSize" value="<%=productSizes.get(i).getSize()%>" readonly/></td>
                                <td class="volumeQty"><%=productSizes.get(i).getVolumeQty()%><input type="hidden" value="<%=productSizes.get(i).getVolumeQty()%>" id="volQty[]" name ="volQty" readonly class="transparentBg" /></td>
                                <td class="deliveredQty"><%=delQty.get(i).getDeliveredQty()%><input type="hidden" value="<%=delQty.get(i).getDeliveredQty()%>" id="deliveredQty[]" name ="deliveredQty" readonly class="transparentBg" /></td>
                                <td><input type="number" name="receivedqty" id="receivedqty[]" class="numericControl inputSize" min="0" value="0" required title="Please Input getDeliveredQty()%>Received Quantity." /></td>
                                <input type="text" class="hidden" readonly name="itemCode" value="<%=delQty.get(i).getItemCode()%>"/>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>
            <!--Buttons-->
            <div id="buttonz" align="center">
                <button class="btn btn-danger">Receive</button>
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
            </div>
            <!--End Sizes-->

            <%}%>
        </form>
    </body>
</html>
