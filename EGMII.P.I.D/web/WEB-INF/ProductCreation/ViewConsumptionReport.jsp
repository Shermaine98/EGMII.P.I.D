<%-- 
    Document   : ViewConsumptionReport
    Created on : 10 1, 15, 12:10:28 AM
    Author     : Geraldine
--%>

<%@page import="Model_General.ProductAll"%>
<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="Model.ConsumptionReport"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/table-design.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
         <script src="js/Validation.js"></script>
        <title>View Consumption Report</title>
        <script>
            $(document).ready(function () {
                $('#view').DataTable({
                    "paging": true,
                    "info": true
                });

                $(".production").on("click", (function () {
                    var productionNumber = $(this).closest("tr").find(".productionNumber").text();
                    document.getElementById('hiddenValue').value = productionNumber;
                    document.getElementById("form1").submit();
                }));
               
        </script>    
        <style>
            .input {
                width: 20px;
            }
        </style>
    </head>
    <body>

        <% String data = (String) request.getAttribute("data");
            ArrayList<ConsumptionReportView> cr = (ArrayList<ConsumptionReportView>) request.getAttribute("crList"); %>
        <!--View Consumption Report-->
        <form id="form1" method="post" action="ViewConsumptionReportServlet?goToC=ViewThis">
            <div class="col-md-8 center1" align="center">
                <h2>View Consumption Report</h2>
                <br/>
                <table id="view" class="table table-bordered table-hover dataTable">
                    <thead>
                        <tr>
                            <th>Production No.</th>
                            <th>Product Name</th>
                            <th>Product Type</th>
                            <th>Date Made</th>
                            <th>Color</th>
                            <th>Prepared By</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            for (int i = 0; i < cr.size(); i++) {
                        %>
                        <tr class="production">
                            <td class="productionNumber"><%= cr.get(i).getProductionNumber()%></td>
                            <td><%= cr.get(i).getProductName()%></td>
                            <td><%= cr.get(i).getProductType()%></td>
                            <td><%= cr.get(i).getDateMade()%></td>
                            <td><%= cr.get(i).getColor()%></td>
                            <td><%= cr.get(i).getName()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <input type="hidden" name="productionNumber" id="hiddenValue" value=""/>
            </div>
        </form> 
        <br/><br/>

        >
        <%
            if (data.equalsIgnoreCase("ViewConsumptionReportSpecific")) {
                ArrayList<ConsumptionReportView> cr1 = (ArrayList<ConsumptionReportView>) request.getAttribute("crListSpecific");

        %>
        <!-- To get the Click row-->
        <div class="container">
            <div class="panel panel-default col-md-3" style="float:left">
                <div class="panel-heading">
                    <h3 class="panel-title">Consumption Report</h3>
                </div>
                <div class="panel-body">
                    <label class="" for="productionNumber">Production Number</label>
                    <input type="text" name="productionNumber" id="productionNumber" class="form-control readonlyWhite" readonly value=<%=cr1.get(0).getProductionNumber()%>  /><br/>
                    <label class="" for="productName">Product Name</label>
                    <input type="text" name="productName" class="form-control readonlyWhite" value="<%=cr1.get(0).getProductName()%>" readonly /><br/>
                    <label for="productType">Product Type</label>
                    <input type="text" name="productType"  class="form-control readonlyWhite" readonly id="productType" value="<%=cr1.get(0).getProductType()%>" /><br/>
                    <label for="color">Color</label>
                    <input type="text" name="color" class="form-control readonlyWhite" value="<%=cr1.get(0).getColor()%>" readonly /><br/>
                    <label for="preparedBy">Prepared By</label>
                    <input type="hidden" name="preparedBy" class="form-control readonlyWhite" value="<%= cr1.get(0).getName()%>" /> <input type="text" name="preparedBy" class="form-control readonlyWhite" value="<%=user.getFirstName()%> <%=user.getLastName()%>" readonly /><br/>
                </div>

            </div>
            <%
                if (cr1.get(0).getProductType().equalsIgnoreCase("Shirt")) {
            %>
            <div class="panel panel-default col-md-7" style="float:left">
                <div class="panel-heading">
                    <h3 class="panel-title">Sizes</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-responsive">
                        <tr>
                            <th><input name="sizeType" class="transparentBg readonlyWhite" value="XS" readonly/></th>
                            <th><input name="sizeType" class="transparentBg readonlyWhite" value="S" readonly/></th>
                            <th><input name="sizeType" class="transparentBg readonlyWhite" value="M" readonly/></th>
                            <th><input name="sizeType" class="transparentBg readonlyWhite" value="L" readonly/></th>
                            <th><input name="sizeType" class="transparentBg readonlyWhite" value="XL" readonly/></th>
                            <th>Total</th></tr>
                        <tr>
                            <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeXS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeM" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeXL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            <td><input name="TotalS" class="transparentBg" id="TotalS" value="0" readonly/></td>
                        </tr>
                    </table>
                </div>
            </div>
            <%
            } else {
            %>
            <!--ELSE HERE-->
            <div class="panel panel-default col-md-7">
                <div class="panel-heading">
                    <h3 class="panel-title">Sizes</h3>
                </div>
                <div class="panel-body table-responsive">
                    <table class="table table-bordered">
                        <!--1-->  
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
                        <tr><td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size29" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size28" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size30" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size31" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size32" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size33" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size34" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size36" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size38" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size40" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            <td><input name="TotalP" class="transparentBg readonlyWhite input" id="TotalP" value="0" readonly/></td>
                        </tr>
                    </table>
                </div>
            </div>
            <%}%>

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
                </div>
                <br/>
            </div>

        </div>
        <!--CLOSE BRACKET HERE-->

        <div align="center">
            <form method="POST" action="PrintConsumptionReport" target="_blank">
                <input type="hidden" id="printPONumber" name="printPONumber" value="<%= cr1.get(0).getProductionNumber()%>"/>
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-danger" >Cancel</button></a>
                <input type="submit" class="btn btn-default" value="Save" />
            </form>
        </div>
        <%
            }
        %>


    </body>
</html>
