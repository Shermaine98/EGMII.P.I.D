<%-- 
    Document   : Supplier Purchase Order
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.ConsumptionReport"%>
<%@page import="Model.BillOfMaterials"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.SupplierPurchaseOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="js/deleteRow.js"></script>
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <link rel="stylesheet" href="bootstrap/css/jquery-ui-datePicker.css">
        <script src="bootstrap/js/jquery-ui.js"></script>
        <script src="js/searchSubcon.js"></script>
        <title>Encode Subcontractor Purchase Order</title>
        <script>
            $(document).ready(function () {
                var subPONumber = '${SubPONumber}';
                document.getElementById('poNumber').value = subPONumber;

            });

        </script>
    </head>

    <body>  
        <br/>
        <!--Search product-->
        <form action="SearchProductsServlet" method="POST" >
            <div align="center" class="container">
                <h2>Encode Subcontractor Purchase Order</h2>
                <div class="input-group col-md-6">
                    <input type="text" class="form-control" name="productName" id="productName" onkeypress="autoComplete();" placeholder="Search Item"/>
                    <input type="hidden" name="productName1" id="productName1" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                    <span class="input-group-btn"><button class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
                </div>
                <br/><br/>
            </div>
        </form>
        <%        ArrayList<ConsumptionReport> consumptionReport = (ArrayList<ConsumptionReport>) request.getAttribute("ConsumptionReportArray");
            ArrayList<String> itemsize = (ArrayList<String>) request.getAttribute("itemSize");
            if (!consumptionReport.isEmpty()) {
        %>
        <form method="POST" action="EncodeSubcontractorPurchaseOrderServlet">
            <div align="center" class="container">

                <div class="panel panel-default col-md-4">
                    <div class="panel-heading">
                        <h3 class="panel-title">Consumption Report</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control readonlyWhite" id="poNumber" readonly /><br/>
                        <label class="" for="productionNumber">Production Number</label>
                        <input type="text" name="productionNumber" class="form-control readonlyWhite"  value="<%=consumptionReport.get(0).getProductionNumber()%>"/><br/>
                        <label class="" for="preparedBy">Purchase Order Number</label>
                        <input type="hidden" name="preparedBy" class="form-control readonlyWhite" id="preparedBy" value="<%= user.getEmployeeNumber()%>" /><br/>
                        <input class="form-control readonlyWhite" value="<%= user.getFirstName()%> <%=user.getLastName()%> " readonly /><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" class="form-control" id="datepicker"  /><br/>
                    </div>
                </div>

                <div class="panel panel-default col-md-6" style="padding-top:20px">
                    <div class="panel-body">

                        <!--Search product result-->  
                        <%
                            if (consumptionReport.get(0).getSizeName().equalsIgnoreCase("Shirt")) {
                        %>  
                        <table class="table table-bordered">
                            <tr>
                                <th colspan="2">Product Name: <input type="hidden" name="productID" id="productID" value="<%= consumptionReport.get(0).getProductID()%>"/>
                                    <input type="text" class="transparentBg readonlyWhite" readonly name="ProductName" id="ProductName" value="<%= consumptionReport.get(0).getProductID()%>"/></th>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="S" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="sizeS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="M" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="sizeM" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="L" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="sizeL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="XL" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="sizeXL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                            </tr>
                            <tr>
                                <th>Total</th>
                                <td><input name="TotalS" class="transparentBg" id="TotalS" value="0" readonly/></td>
                            </tr>
                        </table>

                        <%
                        } else {
                        %>
                        <table class="table table-bordered">
                            <tr>
                                <th colspan="2">Product Name: <input type="hidden" name="productID" id="productID" value="<%= consumptionReport.get(0).getProductID()%>"/>
                                    <input type="text" class="transparentBg readonlyWhite" readonly name="ProductName" id="ProductName" value="<%= consumptionReport.get(0).getProductID()%>"/></th>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="29" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size29" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="30" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size30" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="31" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size31" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="32" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size32" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="33" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size33" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="34" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size34" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="36" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size36" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="38" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="size38" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                            </tr>
                            <tr>
                                <th>Total</th>
                                <td><input name="TotalP" class="transparentBg" id="TotalP" value="0" readonly/></td>
                            </tr>
                        </table>
                        <%
                            }
                        %>

                    </div>
                </div>
            </div>
            <div class="container" align="center">
                <!--Search Subcon-->
                <div class="col-md-6" style="margin-top:30px">
                    <input type="text" class="form-control" name="subconName" id="subconName" onkeypress="autoCompleteSubcon();" placeholder="Search Subcon"/>
                    <input type="hidden" name="subcon" id="subcon" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>

                </div>
                <br/><br/>   
                <!--Result of Search-->    
                <table id="dataSubconService" class="table table-bordered">
                    <!--                <thead>Service<thead>
                                    <tbody>Printing</tbody>
                    -->
                </table>
                <br/><br/>
                <input type="submit" style="width:77px; height:34px" class="btn btn-danger" value="Submit">
                <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>

        </div>
                <%
                    }
                %>
          
        </form>

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
