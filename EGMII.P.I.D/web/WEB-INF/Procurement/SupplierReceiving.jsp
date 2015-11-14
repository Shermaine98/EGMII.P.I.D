<%-- 
    Document   : Supplier Receiving
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
                     var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));

                $(".trclass").on("keyup", (function () {
                    var volumeQty = parseInt($(this).closest("tr").find(".volQty").text());
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
            });

        </script>
    </head>
    <% ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("Receiving");%>
    <body>
        <form method="post" action="SetSupplierSpecificReceivingServlet" id="form1">
            <div class="container" align="center" style="width:60%;">
                <h2>Supplier Purchase Order Receiving</h2><br/>
                <table id ="dataTable" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Purchase Order No.</th>
                            <th>Supplier</th>
                            <th>Delivery Date</th>
                            <th>Prepared By</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < PurchaseOrderList.size(); i++) {%>
                        <tr class="SupplierPOReceiving">
                            <td class="poNumber"><%=PurchaseOrderList.get(i).getPoNumber()%><input type="text" class="transparentBg inputSize" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%=PurchaseOrderList.get(i).getCompanyName()%>" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%=PurchaseOrderList.get(i).getDeliveryDate()%>" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%=PurchaseOrderList.get(i).getPreparedByName()%>" readonly /></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=PurchaseOrderList.get(i).isIsCompleted()%>" readonly /></td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
                <input type="hidden" name="hiddenValueReceiving" id="hiddenValue" value=""/>
            </div>
        </form>
        <%
            String data = (String) request.getAttribute("receivingData");
            if (data.equalsIgnoreCase("receiving")) {
                ArrayList<SupplierPurchaseOrderView> PurchaseOrderSpecific = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderReceiving");
        %>
        <form method="post" action="EncodeSupplierDRServlet">
            <div class="container" align="center">
                <div class="panel panel-default col-md-3" style="padding-bottom:10px; margin-left: 60px;">
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control " readonly name="poNumber" value="<%=PurchaseOrderSpecific.get(0).getPoNumber()%>" /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control " readonly name="preparedBy" value="<%=PurchaseOrderSpecific.get(0).getPreparedBy()%>" /><br/>
                        <label for="preparedBy">Received By</label>
                        <input type="hidden" class="form-control " name="receivedBy" value="<%=user.getEmployeeNumber()%>" /><br/>
                        <input type="text" class="form-control " readonly  value="<%=user.getFirstName()%> <%=user.getLastName()%>" /><br/>
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="text" class="form-control "  name="deliveryDate" readonly value="<%=PurchaseOrderSpecific.get(0).getDeliveryDate()%>"/><br/>
                        <label for="supplier">Supplier</label>
                        <input type="text" class="form-control " readonly name="supplier" value="<%=PurchaseOrderSpecific.get(0).getCompanyName()%>" /><br/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7" style="padding-bottom:10px;">
                    <div class="panel-body">

                        <div class="form-inline">
                            <label for="drNumber">Delivery Receipt Number</label>
                            <input type="text" class="form-control" name="drNumber" pattern=".{8,}" required title="Please Input Delivery Receipt Number." />
                        </div>
                        <br/>

                        <table id="tableReceiving" class="table table-bordered">
                            <colgroup>
                                <col style="width:60%" />
                            </colgroup>
                            <tr>
                                <th>Item Name</th>
                                <th>Quantity</th>
                                <th>Delivered Quantity</th>
                                <th>Received</th>
                            </tr>
                            <%for (int x = 0; x < PurchaseOrderSpecific.size(); x++) {%>
                            <tr class="trclass">
                                <td><%=PurchaseOrderSpecific.get(x).getItemName()%><input type="hidden" name="itemCode" value="<%=PurchaseOrderSpecific.get(x).getItemCode()%>" /></td>
                                <td class="volQty"><%=PurchaseOrderSpecific.get(x).getQty()%><input type="hidden" value="<%=PurchaseOrderSpecific.get(x).getQty()%>" id="volumeQty[]" name ="QtyOrdered" readonly class="transparentBg inputSize" /></td>
                                <td class="deliveredQty"><%=PurchaseOrderSpecific.get(x).getDeliveredQty()%><input type="hidden" value="<%=PurchaseOrderSpecific.get(x).getDeliveredQty()%>" id="deliveredQty[]" name ="deliveredQty" readonly class="transparentBg inputSize" /></td>
                                <td><input type="number" name="receivedqty" id="receivedqty[]" class="transparentBg inputSize" min="0" value="0" required title="Please Input Received Quantity." /></td>
                            </tr>
                            <% } %>
                        </table>

                        <br/>

                    </div>
                </div>
            </div>

            <!--Buttons-->
            <div id="buttonz" align="center">
                <input type="submit" class="btn btn-default"/>
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
            </div>
            <%}%>
        </form>
    </body>
</html>
