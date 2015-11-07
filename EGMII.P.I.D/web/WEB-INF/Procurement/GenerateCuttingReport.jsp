<%-- 
    Document   : ViewCuttingReport
    Created on : Oct 18, 2015, 8:51:06 PM
    Author     : shermainesy
--%>

<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/jquery-ui-datePicker.css">

        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <title>Approve Cutting Report</title>
        <style>
            input[type=number]::-webkit-inner-spin-button, 
            input[type=number]::-webkit-outer-spin-button { 
                -webkit-appearance: none; 
                margin: 0; 
            }
        </style>
        <script> $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $(".cuttingReport").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
            });</script>
    </head>
    <body>
        <form id="form1" method="post" action="GenerateCuttingReportServlet">
            <% String data = (String) request.getAttribute("data");
                ArrayList<ConsumptionReportView> ConsumptionReportView = (ArrayList<ConsumptionReportView>) request.getAttribute("CuttingReport");%>
            <div class="container" align="center">
                <h2>Supplier Purchase Order</h2><br/>
                <div style="width:60%;">
                    <table id="dataTable" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Purchase Order No.</th>
                                <th>Product Name</th>
                                <th>Date Made</th>
                                <th>Color</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < ConsumptionReportView.size(); i++) {%>
                            <tr class="cuttingReport">
                                <td class="poNumber"><%=ConsumptionReportView.get(i).getProductionNumber()%></td>
                                <td><%=ConsumptionReportView.get(i).getProductName()%></td>
                                <td><%=ConsumptionReportView.get(i).getDateMade()%></td>
                                <td><%=ConsumptionReportView.get(i).getColor()%></td>
                                <td><%=ConsumptionReportView.get(i).getPreparedBy()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="poNumber" id="hiddenValue" value=""/>
            </div>
        </form>

        <%
            if (data.equalsIgnoreCase("CuttingReportSpecific")) {
                ArrayList<ConsumptionReportView> ConsumptionReportSpecific = (ArrayList<ConsumptionReportView>) request.getAttribute("CuttingReportSpecific");%>                    
        <form method="POST" action="EncodeSupplierPurchaseOrderServlet">
            <div align="center" class="container">
                <h2>Approve Cutting Report</h2><br/>

                <div class="panel panel-default col-md-3">
                    <div class="panel-body">
                        <label>Production Number</label>
                        <input class="form-control readonlyWhite" type="text" name="productionNo" id="productionNo" value="<%=ConsumptionReportSpecific.get(0).getProductionNumber()%>"readonly /><br/>
                        <label>Purchase Order Number</label>
                        <input class="form-control readonlyWhite" type="text" name="poNumber" id="poNumber" readonly /><br/>
                        <label>Delivery Receipt Number</label>
                        <input class="form-control readonlyWhite" type="text" name="drNumber" id="drNumber" readonly /><br/>
                        <input type="hidden" name="preparedBy" value="0000" />
                        <label>Delivery Date</label>
                        <input type="date" class="form-control readonlyWhite" name="deliveryDate" id="datepicker" readonly /><br/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable3" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Item Code</th>
                                    <th>Size</th>
                                    <th>Calculated Quantity</th>
                                    <th>Actual Quantity</th>
                                    <th>Unit Measurement</th>
                                    <th>Note</th>
                                </tr>
                            </thead>
                            <tbody >
                                <tr>
                                    <td><input type="text" class="transparentBg inputSize" name="itemCode"  value = ""  readonly/></td>
                                    <td><input type="text" class="transparentBg inputSize" name="size"  value = ""  readonly/></td>
                                    <td><input type="number" class="transparentBg inputSize" name="calculatedQty"  value = ""  readonly/></td>
                                    <td><input type="number" class="transparentBg inputSize" name="actualQty"  value = ""  readonly/></td>
                                    <td><input type="text" class="transparentBg inputSize" name="unitMeasurement"  value = ""  readonly/></td>
                                    <td><input type="text" class="transparentBg" name="note"  value = ""  readonly/></td>
                                </tr> 
                            </tbody>
                        </table>
                        <br/><br/>
                        <input type="submit" class="btn btn-danger" value="Approve"/>
                        <button type="button" class="btn btn-danger" >Resend</button>
                        <a href="\..\..\Accounts\Homepage.jsp"><button type="button" class="btn btn-danger" >Cancel</button></a>
                    </div>
                </div>
            </div></form>
            <%}%>
    </body>
</html>
