<%-- 
    Document   : Approval
    Created on : 11 4, 15, 10:58:14 AM
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
        <title>Subcontractor Purchase Order Approval</title>

    </head>
    <body>
        <div class="container" align="center">
            <h2>Approve Subcontractor Purchase Order</h2><br/>

            <table class="table table-bordered" style="width:60%;">
                <colgroup>
                    <col style="width:23%" />
                    <col style="width:35%" />
                </colgroup>
                <tr>
                    <th>Purchase Order No.</th>
                    <th>Subcontractor</th>
                    <th>Date Made</th>
                    <th>Prepared By</th>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>

            <!--Should appear when something is clicked ?-->
            <div>
                <div class="panel panel-default col-md-4 pull-left" style="padding-bottom:10px; margin-left: 60px;">
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="poNumber" /><br/>
                        <label for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="preparedBy" /><br/>
                        <label for="dateMade">Date Made</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="dateMade" /><br/>
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="date" class="form-control" id="datepicker" name="deliveryDate" /><br/>
                        <label for="subcon">Subcontractor</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="subcon" /><br/>
                        <label for="productionNumber">Production Number</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="productionNumber" /><br/>
                        <label for="productName">Product Name</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="productName" /><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="productType" /><br/>
                        <label for="color">Color</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="color" />
                    </div>
                </div>

                <div class="panel panel-default col-md-5" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered">
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
                                <th>Total Quantity</th>
                                <td><input name="TotalS" class="transparentBg" id="TotalS" value="0" readonly/></td>
                            </tr>
                        </table>
                        <div class="form-inline pull-right">
                            <label><b>Unit Price: </b></label>
                            <input type="number" class="form-control readonlyWhite" name="unitPrice" readonly /><br/><br/>
                            <label><b>Total Price: </b></label>
                            <input type="number" class="form-control readonlyWhite" name="totalPrice" readonly /> 
                        </div>
                    </div>
                </div>

                <!--ELSE HERE-->
                <div class="panel panel-default col-md-5">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body">
                        <input type="hidden" name="sizeName"  value="" />
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
                                <th>Total Quantity</th>
                                <td><input name="TotalP" class="transparentBg" id="TotalP" value="0" readonly/></td>
                            </tr>
                        </table>

                        <div class="form-inline pull-right">
                            <label><b>Unit Price: </b></label>
                            <input type="number" class="form-control readonlyWhite" name="unitPrice" readonly /><br/><br/>
                            <label><b>Total Price: </b></label>
                            <input type="number" class="form-control readonlyWhite" name="totalPrice" readonly /> 
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <br/>
        <div id="buttonz" align="center">
            <!--Buttons-->
            <input type="button" value="Approve" class="btn btn-danger" />
            <button class="btn btn-danger">Reject</button><br/><br/>
            <button class="btn btn-danger">Print</button>
        </div>
    </body>
</html>
