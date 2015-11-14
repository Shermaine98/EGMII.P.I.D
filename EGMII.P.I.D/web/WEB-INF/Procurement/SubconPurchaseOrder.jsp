<%-- 
    Document   : Subcon Purchase Order
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.RawMaterialsInventoryView"%>
<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script src="js/Validation.js"></script>
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchSubcon.js"></script>
        <title>Encode Subcontractor Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });
                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".productionNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

                var x = document.getElementById('trigger').value;
                if (x === "true") {
                    $('input[type="submit').prop('disabled', true);
                }
            });
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
                <h2>Encode Subcontractor Purchase Order</h2><br/>
                <div style="width:70%;">
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
                                <td class="productionNumber"><%=ConsumptionReportView.get(i).getProductionNumber()%><input type="text" readonly  class="transparentBg inputSize"/></td>
                                <td><input type="text" class="transparentBg " value="<%=ConsumptionReportView.get(i).getProductName()%>" readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductType()%>" readonly /></td>
                                <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getColor()%>" readonly /></td>
                                <td><input type="text" class="transparentBg" value="<%=ConsumptionReportView.get(i).getName()%>" readonly /></td>
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
        <form method="POST" action="EncodeSubconPurchaseOrderServlet">
            <div align="center" class="container">

                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label for="subconName">Subcontractor</label>
                        <input type="text" class="form-control" name="subconName" id="subconName" pattern=".{1,}" required title="lease Input Subcontractor" onkeypress="autoCompleteSubcon();" placeholder="Search Subcon"/>
                        <br/>  
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" placeholder="yyyy-mm-dd" class="form-control" id="datepicker" pattern=".{1,}" required title="Please Input Delivery Date" /><br/>
                        <!--Search Subcon-->
                        <label class="" for="poNumber">Purchase Order No.</label>
                        <input type="text" name="poNumber" class="form-control " id="poNumber" value="<%=poNumber%>" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="form-control "   value="<%=user.getEmployeeNumber()%>"/><br/>
                        <input type="text" class="form-control " readonly  value="<%=user.getFirstName()%> <%=user.getLastName()%>"/><br/>
                        
                        <label class="" for="productionNumber">Production Number</label>
                        <input type="text" name="productionNumber" id="productionNumber" class="form-control" readonly value=<%=PurchaseOrderSpecific.get(0).getProductionNumber()%>  /><br/>
                        <label class="" for="productName">Product Name</label>
                        <input type="text" name="productName" class="form-control" value="<%=PurchaseOrderSpecific.get(0).getProductName()%>" readonly /><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" name="productType"  class="form-control" readonly id="productType" value="<%=PurchaseOrderSpecific.get(0).getProductType()%>" /><br/>
                        <label for="color">Color</label>
                        <input type="text" name="color" class="form-control" value="<%=PurchaseOrderSpecific.get(0).getColor()%>" readonly /><br/>

                    </div>
                </div>

                <% ArrayList<RawMaterialsInventoryView> rmwi = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("rmwInventory"); %>
                <!--not enough inventory-->
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable3" class="table table-bordered table-hover">
                            <colgroup>
                                <col style="width: 60%" />
                                <col style="width: 40%" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Inventory Balance Quantity</th>
                                </tr>
                            </thead>
                            <tbody> 
                                <%for (int i = 0; i < rmwi.size(); i++) {
                                        if (rmwi.get(i).getQtyNeeded() < 0) {
                                %>
                                <tr style="background-color: #B20000;
                                    color: #FFF;"> 
                                    <td><input onload="disabled()" type="text" value="<%=rmwi.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="hidden" id="trigger" value="true"/><input type="text" value="<%=rmwi.get(i).getQtyNeeded()%>" class="transparentBg" readonly/> 
                                </tr> 
                                <%
                                } else {
                                %>   
                                <tr> 
                                    <td><input type="text" value="<%=rmwi.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="hidden" id="trigger" value=""/><input type="text" value="<%=rmwi.get(i).getQtyNeeded()%>" class="transparentBg" readonly/> 
                                </tr> 
                                <%
                                        }
                                    }%>
                            </tbody>
                        </table>
                    </div>
                </div>


                <!--view here-->
                <!--sizes here-->

                <div class="panel panel-default col-md-7" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered">
                            <%
                                ArrayList<ConsumptionReportView> productSizes = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforSizes");
                            %>
                            <tr>
                                <%
                                    for (int i = 0; i < productSizes.size(); i++) {
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
                                <td><input type="number" readonly class="transparentBg inputSize" name="volumeQty" id="sizeS" value="<%=productSizes.get(i).getVolumeQty()%>" /></td>
                                    <%
                                            total += productSizes.get(i).getVolumeQty();
                                        }
                                    %>  
                                <td><input name="TotalS" class="transparentBg inputSize" id="TotalS" value="<%=total%>" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!--sizes end here-->


                <!--ACCESSORIES-->
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Accessories</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable3" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Consumption</th>
                                    <th>Total Consumption</th>
                                    <th>Unit Measurement</th>
                                </tr>
                            </thead>
                            <tbody >
                                <%
                                    ArrayList<ConsumptionReportView> productAllAcce = (ArrayList<ConsumptionReportView>) request.getAttribute("crListSpecific");
                                    for (int i = 0; i < productAllAcce.size(); i++) {
                                        if (productAllAcce.get(i).getInventoryType().equalsIgnoreCase("accessories")) {
                                %>
                                <!--FOR LOOP-->
                                <tr>
                                    <td><input type="text" class="transparentBg readonlyWhite " name="itemName"  value = "<%= productAllAcce.get(i).getItemName()%>"  readonly/>
                                        <input type="hidden" class="transparentBg readonlyWhite inputSize" name="itemCode"  value = "<%= productAllAcce.get(i).getItemCode()%>" /></td>
                                    <td><input name="itemConsumption" class="transparentBg readonlyWhite inputSize" id="itemConsumption[]" value="<%= productAllAcce.get(i).getVolumeQty()%>"   readonly/></td> 
                                    <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumption[]" value="<%=productAllAcce.get(i).getConsumptionQty()%>"  readonly/></td>
                                    <td><input name="unitMeasurement" class="transparentBg readonlyWhite inputSize" id="unitMeasurement" value="<%= productAllAcce.get(i).getUnitMeasurement()%>"  readonly /></td>
                                </tr> 
                                <%
                                        }
                                    }
                                %>
                                <!--close bracket here-->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- fabric -->
                <div class="panel panel-default col-md-7 pull-right" style="margin-right:140px">
                    <div class="panel-heading">
                        <h3 class="panel-title">Choose Fabric</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable4" class="table table-bordered">
                            <thead>
                                <tr> 
                                    <th>Fabric Name</th>     
                                    <th>Size</th> 
                                    <th>Volume Qty Per Size</th>
                                    <th>Consumption</th>
                                    <th>Unit Measurement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<ConsumptionReportView> productAllproduc = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforFabric");
                                    for (int i = 0; i < productAllproduc.size(); i++) {
                                        if (productAllproduc.get(i).getInventoryType().equalsIgnoreCase("production")) {
                                %>   
                                <tr> 
                                    <td><input type="text" value="<%=productAllproduc.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="text" value="<%=productAllproduc.get(i).getSize()%>" class="transparentBg inputSize" readonly/> 
                                    <td><input type="text" id="fabricItemConsumption[]" value="<%=productAllproduc.get(i).getVolumeQty()%>" class="transparentBg inputSize" readonly/> 
                                    <td><input type="text" class="transparentBg readonlyWhite inputSize" id="totalConsumptionFabric[]" value="<%=productAllproduc.get(i).getConsumptionQty()%>"  readonly/></td>
                                    <td><input type="text" value="<%=productAllproduc.get(i).getUnitMeasurement()%>" class="transparentBg" readonly/> 
                                </tr> 
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                        <table id="dataSubcon"></table>
                    </div>
                    <br/>

                </div>

            </div>

            <div class="container" align="center">
                <br/><br/>
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
                <input type="submit" class="btn btn-danger" value="Submit"/>
            </div>
        </form>
        <%}%>
        <br/><br/>

    </body>
</html>
