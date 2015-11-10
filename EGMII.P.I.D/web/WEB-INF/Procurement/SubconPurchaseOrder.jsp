<%-- 
    Document   : SubconPurchaseOrder
    Created on : 11 4, 15, 10:28:18 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.ConsumptionReportView"%>
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
        <title>Encode Subcontractor Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $(".SubconPO").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".productionNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
            });
            //          $('#run').ready(function(){
            //         document.getElementById("run").addEventListener("load", SolveTQP);
            //          });

        </script>
        <style>
            .input{
                width:20px;
            }
        </style>
    </head>
    <body>
        <br/>
        <% ArrayList<ConsumptionReportView> ConsumptionReportView = (ArrayList<ConsumptionReportView>) request.getAttribute("ConsumptionList");%>
        <form id="form1" method="post" action="SetSubconPOSpecificSerlvet">
            <div class="container" align="center">
                <h2>Search Consumption Report</h2><br/>
                <div style="width:60%;">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Production Number</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Color</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < ConsumptionReportView.size(); i++) {%>
                            <tr class="SubconPO">  
                                <td class="productionNumber"><%=ConsumptionReportView.get(i).getProductionNumber()%></td>
                                <td><%=ConsumptionReportView.get(i).getProductName()%></td>
                                <td><%=ConsumptionReportView.get(i).getProductType()%></td>
                                <td><%=ConsumptionReportView.get(i).getColor()%></td>
                                <td><%=ConsumptionReportView.get(i).getName()%></td>
                            </tr> 
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </form>
                        <br/>
        <% String data = (String) request.getAttribute("subconData");
            if (data.equalsIgnoreCase("consumption")) {
                Integer poNumber = (Integer) request.getAttribute("poNumber");
                ArrayList<ConsumptionReportView> PurchaseOrderSpecific = (ArrayList<ConsumptionReportView>) request.getAttribute("ConsumptionSpecific");
        %>
        <form method="POST" action="EncodeSubcontractorPurchaseOrderServlet">
            <div align="center" class="container">

                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control readonlyWhite" id="poNumber" value="<%=poNumber%>" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="form-control readonlyWhite"  value="<%=user.getEmployeeNumber()%>"/><br/>
                        <input type="text" class="form-control readonlyWhite"  value="<%=user.getFirstName()%> <%=user.getLastName()%>"/><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" id="datepicker" class="form-control" pattern=".{1,}" required title="Please Input Delivery Date"  /><br/>
                        <!--Search Subcon-->
                        <label for="subconName">Subcontractor</label>
                        <input type="text" class="form-control" name="subconName" id="subconName" pattern=".{1,}" required title="lease Input Subcontractor" onkeypress="autoCompleteSubcon();" placeholder="Search Subcon"/>
                        <input type="hidden" name="subcon" id="subcon" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                        <br/>  

                    </div>
                </div>

                <div class="panel panel-default col-md-7 ">
                    <div class="panel-heading">
                        <h3 class="panel-title">Details</h3>
                    </div>
                    <div class="panel-body">
                        <div style="width:70%">
                            <label for="productionNumber">Production Number</label>
                            <input type="text" name="productionNumber" class="form-control readonlyWhite" readonly /><br/>
                            <label for="productName">Product Name</label>
                            <input type="text" name="productName" class="form-control readonlyWhite" readonly /><br/>
                            <label for="productType">Product Type</label>
                            <input type="text" name="productType" class="form-control readonlyWhite" readonly /><br/>
                            <label for="color">Color</label>
                            <input type="text" name="color" class="form-control readonlyWhite" readonly /><br/>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default col-md-7 pull-right" style="margin-right:140px">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <!--Search product result--> 
                        <table class="table table-bordered">
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="XS" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="S" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="M" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="L" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="XL" readonly/></th>
                                <th>Total</th>
                            </tr>
                            <tr>
                                <td><input type="number" class="transparentBg input" name="volumeQty" id="sizeXS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" class="transparentBg input" name="volumeQty" id="sizeS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" class="transparentBg input" name="volumeQty" id="sizeM" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" class="transparentBg input" name="volumeQty" id="sizeL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" class="transparentBg input" name="volumeQty" id="sizeXL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input name="TotalS" class="transparentBg input" id="TotalS" value="0" readonly/></td>
                            </tr>
                        </table>


                        <table class="table table-bordered">
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="28" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="29" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="30" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="31" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="32" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="33" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="34" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="36" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="38" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="40" readonly/></th>
                                <th>Total</th>
                            </tr>
                            <!--2-->  
                            <tr><td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size29" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size28" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size30" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size31" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size32" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size33" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size34" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size36" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size38" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" class="transparentBg readonlyWhite input" name="volumeQty" id="size40" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input name="TotalP" class="transparentBg readonlyWhite input" id="TotalP" value="0" readonly/></td>
                            </tr>
                        </table>

                        <!--                        Unit Price:
                                                <input type="number" name="unitPrice" value="" readonly class="form-control readonlyWhite" /><br/>
                                                Total:
                                                <input type="number" name="Total" value="" readonly class="form-control readonlyWhite" /><br/>-->
                    </div>
                </div>
            </div>

            <div class="container" align="center">
                <!--Result of Search-->    
                <table id="dataSubconService" class="table table-bordered">
                    <!--                <thead>Service<thead>
                                    <tbody>Printing</tbody>
                    -->
                </table>
                <br/><br/>
                  <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-danger" >Cancel</button></a>
                <input type="submit" class="btn btn-danger" value="Submit">\
            </div>

        </form>
        <%}%>
        <br/><br/>
        <script>
            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });

            function autoComplete() {
                $("#productName").devbridgeAutocomplete({
                    serviceUrl: 'SearchProductsServlet',
                    type: 'POST',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: 'No Exsiting Product'
                });
            }
        </script>
    </body>
</html>
