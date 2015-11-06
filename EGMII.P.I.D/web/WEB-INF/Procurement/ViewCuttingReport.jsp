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
                "info": true,
//                    "dom": '<"pull-left "f>'
            });

            $(".cuttingReport").on("click", (function () {
                var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                document.getElementById('hiddenValue').value = purchaseOrderNum;
                document.getElementById("form1").submit();
            }));
        });</script>
    </head>
    <body>
        <% ArrayList<ConsumptionReportView> ConsumptionReportView = (ArrayList<ConsumptionReportView>) request.getAttribute("consumptionReportCutting");%>
        <div class="container" align="center">
            <h2>Approve Supplier Purchase Order</h2><br/>
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
                        <tr class="SupplierPOView">
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
            <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
        </div>
        <div align="center" class="container">
            <h2>Approve Cutting Report</h2><br/>
            <form method="POST" action="EncodeSupplierPurchaseOrderServlet">

                <table class="table table-bordered" style="width:40%">
                    <colgroup>
                        <col style="width:40%"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>Production No.</th>
                            <td class="value"><input class="input" type="text" name="productionNo" id="productionNo" readonly /></td>
                        </tr>
                        <tr>
                            <th>Purchase Order No.</th>
                            <td class="value"><input class="input" type="text" name="poNumber" id="poNumber" readonly /></td>
                        </tr>
                        <tr>
                            <th>Delivery Receipt No.</th>
                            <td class="value"><input class="input" type="text" name="drNumber" id="drNumber" readonly /></td>
                        </tr>
                        <tr>
                            <th>Cutting Master</th>
                            <td><input type="hidden" name="preparedBy" value="0000"></td>
                        </tr><tr>
                            <th>Date Made </th>
                            <td><input type="text" class="input" name="deliveryDate" id="datepicker"></td>                 
                        </tr>
                    </thead>
                </table>
                <table  id="dataTable3" class="table detailsWidth table-bordered">
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
                            <td><input type="text" class="input" name="itemCode"  value = ""  readonly/></td>
                            <td><input type="text" class="input" name="size"  value = ""  readonly/></td>
                            <td><input type="text" class="input" name="calculatedQty"  value = ""  readonly/></td>
                            <td><input type="text" class="input" name="actualQty"  value = ""  readonly/></td>
                            <td><input type="text" class="input" name="unitMeasurement"  value = ""  readonly/></td>
                            <td><input type="text" class="input" name="note"  value = ""  readonly/></td>
                        </tr> 
                    </tbody>
                </table>
            </form>
            <input type="submit" style="width:77px; height:34px" class="btn btn-danger" value="Approve"/>
            <button type="button" class="btn btn-danger" >Resend</button>
            <a href="\..\..\Accounts\Homepage.jsp"><button type="button" class="btn btn-danger" >Cancel</button></a>
        </div>
    </body>
</html>
