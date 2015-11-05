<%-- 
    Document   : SubconPurchaseOrder
    Created on : 11 4, 15, 10:28:18 AM
    Author     : Geraldine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>Encode Subconractor Purchase Order</title>
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


        <form method="POST" action="EncodeSubcontractorPurchaseOrderServlet">
            <div align="center" class="container">

                <div class="panel panel-default col-md-4">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control readonlyWhite" id="poNumber" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="text" name="preparedBy" class="form-control readonlyWhite"  value=""/><br/>
                        <label class="" for="dateMade">Date Made</label>
                        <input type="hidden" name="dateMade" class="form-control readonlyWhite" id="dateMade" value="" /><br/>
                        <input class="form-control readonlyWhite" value="" readonly /><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" class="form-control" id="datepicker"  /><br/>
                        <!--Search Subcon-->
                        <label for="subconName">Subcontractor</label>
                        <input type="text" class="form-control" name="subconName" id="subconName" onkeypress="autoCompleteSubcon();" placeholder="Search Subcon"/>
                        <input type="hidden" name="subcon" id="subcon" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                        <br/>  

                    </div>
                </div>

                <div class="panel panel-default col-md-6">
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
                
                <div class="panel panel-default col-md-6">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body">
                        <!--Search product result--> 
                        <table class="table table-bordered" style="width:50%">
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="XS" readonly/></th>
                                <td><input type="number" class="transparentBg" name="volumeQty" id="sizeXS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
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


                        <table class="table table-bordered" style="width:50%">
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
                <input type="submit" style="width:77px; height:34px" class="btn btn-danger" value="Submit">
                <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>

            </div>

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
