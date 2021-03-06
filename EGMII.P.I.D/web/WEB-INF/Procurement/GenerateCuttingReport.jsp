<%-- 
    Document   : Generate Cutting Report
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
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
        <script src="js/Validation.js"></script>
        <script src="js/Print.js"></script>
        <title>Approve Cutting Report</title>
        <style>
            input[type=number]::-webkit-inner-spin-button, 
            input[type=number]::-webkit-outer-spin-button { 
                -webkit-appearance: none; 
                margin: 0; 
            }
            label{
                font-weight:bold;
            }
        </style>
        <script> $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
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
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Production Number</th>
                                <th>Product Name</th>
                                <th>Date Made</th>
                                <th>Color</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < ConsumptionReportView.size(); i++) {%>
                            <tr class="cuttingReport">
                                <td class="poNumber"><%=ConsumptionReportView.get(i).getProductionNumber()%><input type="text" class="transparentBg inputSize"/></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getProductName()%>" readonly /></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getDateMade()%>" readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getColor()%>" readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getName()%>" readonly /></td>
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
                ArrayList<ConsumptionReportView> ConsumptionReportSpecific = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforCutting");

        %>                    
        <div  id="printableArea" style="display: none; visibility:hidden; margin-left: 50px; margin-right:50px;">
            <h2 align="center">Cutting Report</h2><br/>
            <h4>Production Number: <%=ConsumptionReportSpecific.get(0).getProductionNumber()%><br/>
                Product: <%=ConsumptionReportSpecific.get(0).getProductName()%><br/>
                Cutting Master: <%= user.getFirstName()%> <%= user.getLastName()%><br/></h4><br/>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Size</th>
                        <th>Item Code</th>
                        <th>Item Name</th>
                        <th>Consumption Per Unit</th>
                        <th>Total Consumption</th>
                        <th>Expected Cut Quantity</th>
                    </tr>
                </thead>
                <tbody >
                    <%
                        for (int i = 0; i < ConsumptionReportSpecific.size(); i++) {
                    %>
                    <tr>
                        <td><input type="text" class="transparentBg inputSize" style="width: 30px;"  value = "<%=ConsumptionReportSpecific.get(i).getSize()%>"  readonly/></td>
                        <td><input type="text" class="transparentBg inputSize" style="width:85px" value = "<%=ConsumptionReportSpecific.get(i).getItemCodeRM()%>"  readonly/></td>
                        <td><input type="text" class="transparentBg" value = "<%=ConsumptionReportSpecific.get(i).getItemName()%>"  readonly/></td>
                        <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportSpecific.get(i).getConsumptionQty()%>"  readonly /></td>
                        <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportSpecific.get(i).getTotalQty()%>"  readonly /></td>
                        <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportSpecific.get(i).getVolumeQty()%>"  readonly /></td>
                    </tr> 
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div align="center" class="container">
            <h2>View Cutting Report</h2><br/>

            <div class="panel panel-default col-md-3">
                <div class="panel-heading">
                    <h3 class="panel-title">Cutting Report</h3>
                </div>
                <div class="panel-body h5" align="left">
                    <label>Production Number</label>
                    <%=ConsumptionReportSpecific.get(0).getProductionNumber()%><br/><br/>
                    <label>Product</label>
                    <%=ConsumptionReportSpecific.get(0).getProductName()%><br/><br/>
                    <label>Cutting Master</label>
                    <input type="text" class="transparentBg" name="size"  value = " <%= user.getFirstName()%> <%= user.getLastName()%>"  readonly/><br/>
                    <input type="hidden" class="transparentBg" name="size"  value = " <%= user.getEmployeeNumber()%>"  />

                </div>
            </div>

            <div class="panel panel-default col-md-7">
                <div class="panel-heading">
                    <h3 class="panel-title">Details</h3>
                </div>
                <div class="panel-body table-responsive">
                    <table id="dataTable3" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Size</th>
                                <th>Item Code</th>
                                <th>Item Name</th>
                                <th>Consumption Per Unit</th>
                                <th>Total Consumption</th>
                                <th>Expected Cut Quantity</th>

                            </tr>
                        </thead>
                        <tbody >
                            <%
                                for (int i = 0; i < ConsumptionReportSpecific.size(); i++) {
                            %>
                            <tr>
                                <td><input type="text" class="transparentBg" name="size" style="width: 30px;"  value = "<%=ConsumptionReportSpecific.get(i).getSize()%>"  readonly/></td>
                                <td><input type="text" class="transparentBg" style="width:85px" name="itemCode"  value = "<%=ConsumptionReportSpecific.get(i).getItemCodeRM()%>"  readonly/></td>
                                <td><input type="text" class="transparentBg" name="itemName"  value = "<%=ConsumptionReportSpecific.get(i).getItemName()%>"  readonly/></td>
                                <td><input type="text" class="transparentBg inputSize" name="consumption" value="<%=ConsumptionReportSpecific.get(i).getConsumptionQty()%>"  readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" name="expectedQty" value="<%=ConsumptionReportSpecific.get(i).getTotalQty()%>"  readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" name="quantity" value="<%=ConsumptionReportSpecific.get(i).getVolumeQty()%>"  readonly /></td>
                            </tr> 
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <center>
        <br/><br/>
        <input type="button" class="btn btn-default" onclick="printDiv('printableArea')" value="Print" />
        <a href="\..\..\Accounts\Homepage.jsp"><button type="button" class="btn btn-primary" >Cancel</button></a>
    </center>
    <%}%>
</body>
</html>
