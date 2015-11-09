<%-- 
    Document   : ConsumptionReport
    Created on : 11 4, 15, 9:49:49 AM
    Author     : Geraldine
--%>

<%@page import="Model_General.ProductAll"%>
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
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <title>Encode Consumption Report</title> 
        <style>
            .input {
                width: 20px;
            }
        </style>
    </head>
    <body>
        <div align="center">
            <h2>Encode Consumption Report</h2>
            <form method="POST" action="SearchProductServlet">
                <div class="input-group col-md-4">
                    <input type="text" name="productName1" class="form-control" id="productName1" onkeypress="autoComplete();" placeholder="Search Item"/>
                    <input type="hidden" name="productName1" id="productName1" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                    <span class="input-group-btn"><button class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
                </div>
                <br/><br/>
            </form>
        </div>
        <%             Integer productionNumber = (Integer) request.getAttribute("CRPRNumber");
            ArrayList<ProductAll> productAll = (ArrayList<ProductAll>) request.getAttribute("ProductList");
            if (!productAll.isEmpty()) {
        %>
        <!--IF STATEMENT HERE-->


        <form method="POST" action="EncodeConsumptionReportServlet">
            <div align="center" class="container">
                <div class="panel panel-default col-md-3" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Encode Consumption Report</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="productionNumber">Production Number</label>
                        <input type="text" name="productionNumber" id="productionNumber" class="form-control readonlyWhite" readonly value=<%=productionNumber%>  /><br/>
                        <label class="" for="productName">Product Name</label>
                        <input type="text" name="productName" class="form-control readonlyWhite" value="<%=productAll.get(0).getProductName()%>" readonly /><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" name="productType"  class="form-control readonlyWhite" readonly id="productType" value="<%=productAll.get(0).getProductType()%>" /><br/>
                        <label for="color">Color</label>
                        <input type="text" name="color" class="form-control readonlyWhite" value="<%=productAll.get(0).getColor()%>" readonly /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy"  class="form-control readonlyWhite" value="<%=user.getEmployeeNumber()%>" /> <input type="text" readonly name="preparedBy" class="form-control readonlyWhite" value="<%=user.getFirstName()%> <%=user.getLastName()%>"/><br/>
                    </div>

                </div>
                <%
                    if (productAll.get(0).getProductType().equalsIgnoreCase("shirt")) {
                %>
                <div class="panel panel-default col-md-7" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered table-responsive">
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="XS" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="S" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="M" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="L" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="XL" readonly/></th>
                                <th>Total</th></tr>
                            <tr>
                                <td><input type="number" min="0" class="transparentBg input" name="volumeQty" id="sizeXS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg input" name="volumeQty" id="sizeS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg input" name="volumeQty" id="sizeM" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg input" name="volumeQty" id="sizeL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg input" name="volumeQty" id="sizeXL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input name="TotalS" min="0" class="transparentBg input" id="TotalS" value="0" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
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
                            <tr><td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size28" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size29" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size30" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size31" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size32" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size33" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size34" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size36" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size38" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" min="0" class="transparentBg readonlyWhite input" name="volumeQty" id="size40" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input name="TotalP" class="transparentBg readonlyWhite input" id="TotalP" value="0" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <%}%>
                <!--CLOSE BRACKET HERE-->

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
                                    ArrayList<ProductAll> productAllAcce = (ArrayList<ProductAll>) request.getAttribute("AccessoriesInventory");
                                    for (int i = 0; i < productAllAcce.size(); i++) {
                                %>
                                <!--FOR LOOP-->
                                <tr>
                                    <td><input type="text" class="transparentBg readonlyWhite" name="itemName"  value = "<%= productAllAcce.get(i).getItemName()%>"  readonly/>
                                        <input type="hidden" class="transparentBg readonlyWhite inputSize" name="itemCode"  value = "<%= productAllAcce.get(i).getItemCode()%>"  /></td>
                                    <td><input name="itemConsumption" class="transparentBg readonlyWhite inputSize" id="itemConsumption[]" value="<%= productAllAcce.get(i).getQty()%>"   readonly/></td> 
                                    <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumption[]" value="0"  readonly/></td>
                                    <td><input name="unitMeasurement" class="transparentBg readonlyWhite inputSize" id="unitMeasurement" value="<%= productAllAcce.get(i).getUnitMeasurement()%>"  readonly /></td>
                                </tr> 
                                <%
                                    }
                                %>
                                <!--close bracket here-->
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-default col-md-7 pull-right" style="margin-right: 140px;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Choose Fabric</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable4" class="table table-bordered">
                            <thead>
                                <tr> 
                                    <th>Fabric Name</th>     
                                    <th>Size</th> 
                                    <th>Consumption</th>
                                    <th>Total Consumption</th>
                                    <th>Unit Measurement</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    ArrayList<ProductAll> productAllproduc = (ArrayList<ProductAll>) request.getAttribute("ProductionInventory");
                                    for (int i = 0; i < productAllproduc.size(); i++) {
                                %>   
                                <tr> 
                                    <td><input type="text" value="<%=productAllproduc.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="text" id="FabricName[]" value="<%=productAllproduc.get(i).getSize()%>" class="transparentBg inputSize" readonly/> 
                                    <td><input type="text" id="fabricItemConsumption[]" value="<%=productAllproduc.get(i).getQty()%>" class="transparentBg inputSize" readonly/> 
                                    <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumptionFabric[]" value="0"  readonly/></td>
                                    <td><input type="text" value="<%=productAllproduc.get(i).getUnitMeasurement()%>" class="transparentBg inputSize" readonly/> 
                                </tr> 
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <br/>
                </div>
            </div>
            <div align="center">
                <input type="submit" class="btn btn-danger" value="Create"/>
                <a href="\..\..\Accounts\Homepage.jsp"><button type="button" class="btn btn-danger" >Cancel</button></a>
            </div>
        </form>
        <!--close bracket here-->
        <%
            }
        %>
        <script>
            var x = false;
            function autoComplete() {
                $("#productName1").devbridgeAutocomplete({
                    serviceUrl: 'SearchProductServlet',
                    type: 'POST',
                    showNoSuggestionNotice: true,
                    noSuggestionNotice: 'No Exsiting Product'
                });
            }
            function calculateTotalShirt() {
                var sizeXS = parseInt(document.getElementById('sizeXS').value);
                var sizeS = parseInt(document.getElementById('sizeS').value);
                var sizeM = parseInt(document.getElementById('sizeM').value);
                var sizeL = parseInt(document.getElementById('sizeL').value);
                var sizeXL = parseInt(document.getElementById('sizeXL').value);
                var totalS = sizeXS + sizeS + sizeM + sizeL + sizeXL;
                document.getElementById('TotalS').value = totalS;
                 x = true;
                SolveTotal(totalS);
               
            }
            function calculateTotalPants() {
                var size28 = parseInt(document.getElementById('size28').value);
                var size29 = parseInt(document.getElementById('size29').value);
                var size30 = parseInt(document.getElementById('size30').value);
                var size31 = parseInt(document.getElementById('size31').value);
                var size32 = parseInt(document.getElementById('size32').value);
                var size33 = parseInt(document.getElementById('size33').value);
                var size34 = parseInt(document.getElementById('size34').value);
                var size36 = parseInt(document.getElementById('size36').value);
                var size38 = parseInt(document.getElementById('size38').value);
                var size40 = parseInt(document.getElementById('size40').value);

                var totalP = size28 + size29 + size30 + size31 + size32 + size33 + size34 + size36 + size38 + size40;
                document.getElementById('TotalP').value = totalP;
                  x = false;
                SolveTotal(totalP);
            }

            function SolveTotal(Total) {
                if (x===true) {
                    var sizeXS = parseInt(document.getElementById('sizeXS').value);
                    var sizeS = parseInt(document.getElementById('sizeS').value);
                    var sizeM = parseInt(document.getElementById('sizeM').value);
                    var sizeL = parseInt(document.getElementById('sizeL').value);
                    var sizeXL = parseInt(document.getElementById('sizeXL').value);
                } else {
                    var size28 = parseInt(document.getElementById('size28').value);
                    var size29 = parseInt(document.getElementById('size29').value);
                    var size30 = parseInt(document.getElementById('size30').value);
                    var size31 = parseInt(document.getElementById('size31').value);
                    var size32 = parseInt(document.getElementById('size32').value);
                    var size33 = parseInt(document.getElementById('size33').value);
                    var size34 = parseInt(document.getElementById('size34').value);
                    var size36 = parseInt(document.getElementById('size36').value);
                    var size38 = parseInt(document.getElementById('size38').value);
                    var size40 = parseInt(document.getElementById('size40').value);
                }

                $("#dataTable3 tbody tr").each(function () {
                    var $this = $(this);
                    var CPU = parseInt($this.find('[id="itemConsumption\\[\\]"]').val());
                    var STotal = (CPU * Total);
                    $this.find('[id="totalConsumption\\[\\]"]').val(STotal);
                });
//solve per fabric
                $("#dataTable4 tbody tr").each(function () {
                    var $this = $(this); 
                    var STotal = 0;
                    var size = $this.find('[id="FabricName\\[\\]"]').val();
                    console.log(size);
                    if (x === true) {
                        if (size === "xs") {
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (sizeXS * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        } else if (size === "s") {
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (sizeS * CPU);
                            
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        } else if (size === "m") {
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (sizeM * CPU);
                            $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        } else if (size === "l") {
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (sizeL * CPU);
                            $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        } else if (size === "xl") {
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (sizeXL * CPU);
                            $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        }
                    }else{
                        if(size==="28"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size28 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        }else if(size === "29"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size29 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        }else if(size === "30"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size30 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                        }else if(size === "31"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size31 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "32"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size32 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "33"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size33 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "33"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size33 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "34"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size34 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "36"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size36 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "38"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size38 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }else if(size === "40"){
                            var CPU = parseInt($this.find('[id="fabricItemConsumption\\[\\]"]').val());
                            var temp = (size40 * CPU);
                           $this.find('[id="totalConsumptionFabric\\[\\]"]').val(temp);
                       }
                        
                    }
                    
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


        </script>              
    </body>
</html>
