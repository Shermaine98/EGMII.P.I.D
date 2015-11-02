<%-- 
    Document   : EncodeConsumptionReport
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.BillOfMaterials"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.ConsumptionReport"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <title>Encode Consumption Report</title>
    </head>
    <body>  
        <div align="center">
            <h2>Encode Consumption Report</h2>
            <form method="POST" action="SearchProductServlet">
                <div class="input-group col-md-3">
                    <input type="text" name="productName1" class="form-control" id="productName1" onkeypress="autoComplete();" placeholder="Search Item"/>
                    <input type="hidden" name="productName1" id="productName1" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                    <span class="input-group-btn"><button onClick="getItem()" class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
                </div>
                <br/><br/>
            </form>
        </div>
        <%        ArrayList<BillOfMaterials> billOfMaterialspID = (ArrayList<BillOfMaterials>) request.getAttribute("BillofMaterials");
            if (!billOfMaterialspID.isEmpty()) {
        %>

        <div align="center" class="container">
            <form method="POST" action="EncodeConsumptionReportServlet">
                <div class="container">
                    <div class="panel panel-default col-md-4" style="float:left">
                        <div class="panel-heading">
                            <h3 class="panel-title">Encode Consumption Report</h3>
                        </div>
                        <div class="panel-body">
                            <label class="" for="productionNumber">Production Number</label>
                            <input type="text" name="productionNumber" id="productionNumber" class="form-control readonlyWhite"  readonly /><br/>
                            <label class="" for="preparedBy">Prepared By</label>
                            <input type="hidden" name="preparedBy" id="preparedBy" value="<%=user.getEmployeeNumber()%> " />
                            <input type="text" class="form-control readonlyWhite" value="<%=user.getFirstName()%> <%=user.getLastName()%> " readonly /><br/>
                        <div class="panel-heading">
                            <h3 class="panel-title">Bill of Materials</h3>
                        </div>
                        <div class="panel-body">
                            <label class="" for="productID">Product ID</label>
                            <input name="productID" class="form-control transparentBg readonlyWhite" readonly value="<%=billOfMaterialspID.get(0).getProductID()%>"/>
                        </div>
                        </div>
                       
                    </div>
                    <%
                        if (billOfMaterialspID.get(0).getSizeName().equalsIgnoreCase("Shirt")) {
                    %>
                    <div class="panel panel-default col-md-5" style="float:left">
                        <div class="panel-heading">
                            <h3 class="panel-title">Size Shirts</h3>
                        </div>
                        <div class="panel-body">
                            <table class="table table-bordered">
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
                        </div>
                    </div>

                    <%
                    } else {
                    %>
                    <div class="panel panel-default col-md-5">
                        <div class="panel-heading">
                            <h3 class="panel-title">Size Pants</h3>
                        </div>
                        <div class="panel-body">
                            <input type="hidden" name="sizeName"  value="<%=billOfMaterialspID.get(0).getSizeName()%>" />
                            <table class="table table-bordered">
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
                        </div>
                    </div>
                </div>
                <%
                    }
                %>

                <div class="container" align="center" style="margin-top:35px;">
                    <div class="panel panel-default col-md-6" style="padding:10px; padding-top:10px;">
                       <div class="panel-heading">
                            <h3 class="panel-title">Bill of Materials Details</h3>
                        </div>
                        <div class="panel-body">
                            <table id="dataTable3" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Item Name</th>
                                        <th>Consumption Per Unit</th>
                                        <th>Total Consumption</th>
                                    </tr>
                                </thead>
                                <tbody >
                                    <%
                                        for (int i = 0; i < billOfMaterialspID.size(); i++) {
                                    %>
                                    <tr>
                                        <td><input type="text" class="transparentBg readonlyWhite" name="itemCode"  value = "<%=billOfMaterialspID.get(i).getItemCode()%>"  readonly/></td>
                                        <td><input name="itemConsumption" class="transparentBg readonlyWhite" id="itemConsumption[]"   value="<%=billOfMaterialspID.get(i).getItemConsumption()%>" readonly/></td>               
                                        <td><input name="totalConsumption" class="transparentBg readonlyWhite" id="totalConsumption[]" value="0"  readonly/></td>
                                    </tr> 
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>  
             <input type="submit" class="btn btn-danger" value="Submit"/>
            <a href="\..\..\Accounts\Homepage.jsp"><button type="button" class="btn btn-danger" >Cancel</button></a>
            </form>
            <br/><br/>
           
        </div>
        <%
            }
        %>      

        <script>

            function autoComplete() {
                $("#productName1").devbridgeAutocomplete({
                    serviceUrl: 'SearchProductServlet',
                    type: 'POST',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: 'No Exsiting Item',
                });
            }
            ;
            function calculateTotalShirt() {
                var sizeS = parseInt(document.getElementById('sizeS').value);
                var sizeM = parseInt(document.getElementById('sizeM').value);
                var sizeL = parseInt(document.getElementById('sizeL').value);
                var sizeXL = parseInt(document.getElementById('sizeXL').value);
                var totalS = sizeS + sizeM + sizeL + sizeXL;
                document.getElementById('TotalS').value = totalS;
                SolveTotal(totalS);
            }
            function calculateTotalPants() {
                var size29 = parseInt(document.getElementById('size29').value);
                var size30 = parseInt(document.getElementById('size30').value);
                var size31 = parseInt(document.getElementById('size31').value);
                var size32 = parseInt(document.getElementById('size32').value);
                var size33 = parseInt(document.getElementById('size33').value);
                var size34 = parseInt(document.getElementById('size34').value);
                var size36 = parseInt(document.getElementById('size36').value);
                var size38 = parseInt(document.getElementById('size38').value);

                var totalP = size29 + size30 + size31 + size32 + size33 + size34 + size36 + size38;
                document.getElementById('TotalP').value = totalP;
                SolveTotal(totalP);
            }

            function SolveTotal(Total) {

                $("#dataTable3 tbody tr").each(function () {
                    var $this = $(this);
                    var CPU = parseInt($this.find('[id="itemConsumption\\[\\]"]').val());
                    var STotal = (CPU * Total);
                    $this.find('[id="totalConsumption\\[\\]"]').val(STotal);
                });
                return false;
            }
            $('form').on('focus', 'input[type=number]', function (e) {
                $(this).on('mousewheel.disableScroll', function (e) {
                    e.preventDefault();
                });
            });
            $('form').on('blur', 'input[type=number]', function (e) {
                $(this).off('mousewheel.disableScroll');
            });
            
            $(document).ready(function () {
                var pdID = '${CRPRNumber}';
                document.getElementById('productionNumber').value = pdID;
            });
        </script>              
    </body>
</html>
