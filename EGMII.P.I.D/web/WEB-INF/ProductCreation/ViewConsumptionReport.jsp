<%-- 
    Document   : ViewConsumptionReport
    Created on : 10 1, 15, 12:10:28 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.ProductAll"%>
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
                $("#view tbody").on("click", 'input[type="text"]', (function () {
                    var productionNumber = $(this).closest("tr").find(".productionNumber").text();
                    document.getElementById('hiddenValue').value = productionNumber;
                    document.getElementById("form1").submit();
                }));
            });
        </script>    
        <style>
            .input {
                width: 20px;
            }
            label{
                font-weight: bold;
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
                            <th>status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            for (int i = 0; i < cr.size(); i++) {
                        %>
                        <tr class="production">
                            <td class="productionNumber"><%= cr.get(i).getProductionNumber()%><input type="text" class="transparentBg inputSize" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%= cr.get(i).getProductName()%>" readonly /></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%= cr.get(i).getProductType()%>" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%= cr.get(i).getDateMade()%>" readonly /></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%= cr.get(i).getColor()%>" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%= cr.get(i).getName()%>" readonly /></td>
                            <td><input type="text" class="transparentBg" value="<%= cr.get(i).getStatus()%>" readonly /></td>
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
                <div class="panel-body h5">
                    <label>Production Number: </label>
                    <%=cr1.get(0).getProductionNumber()%> <br/><br/>
                    <label>Product Name: </label>
                    <%=cr1.get(0).getProductName()%> <br/><br/>
                    <label>Product Type: </label>
                    <%=cr1.get(0).getProductType()%><br/><br/>
                    <label>Color: </label>
                    <%=cr1.get(0).getColor()%> <br/><br/>
                    <label>Prepared By: </label>
                    <input type="hidden" name="preparedBy" class="form-control readonlyWhite" value="<%= cr1.get(0).getName()%>" /> 
                    <%=user.getFirstName()%> <%=user.getLastName()%><br/>

                </div>
            </div>

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
                            <th><input name="sizeType" class="transparentBg readonlyWhite input" value="<%=productSizes.get(i).getSize()%>" readonly/></th>
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
                                <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumption[]" value="<%=productAllAcce.get(i).getConsumptionQty()%>"  readonly/></td>
                                <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumption[]" value="<%=productAllAcce.get(i).getConsumptionQty() * total%>"  readonly/></td>
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
                                <th>Total Consumption</th>
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
                                <td><input type="text" class="transparentBg readonlyWhite inputSize" id="totalConsumptionFabric[]" value="<%=productAllproduc.get(i).getConsumptionQty() * productAllproduc.get(i).getVolumeQty()%>"  readonly/></td>
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
                <input type="submit" class="btn btn-danger" value="Save" />
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
            </form>
        </div>
        <%
            }
        %>


    </body>
</html>