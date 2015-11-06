<%-- 
    Document   : SupplierReceiving
    Created on : 11 4, 15, 1:43:12 PM
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
        <title>Receiving</title>
    </head>
    <body>
        <div class="container" align="center">
            <h2>Subcontractor Purchase Order Receiving</h2><br/>

            <table class="table table-bordered" style="width:60%;">
                <colgroup>
                    <col style="width:23%" />
                    <col style="width:30%" />

                </colgroup>
                <tr>
                    <th>Purchase Order No.</th>
                    <th>Subcontractor</th>
                    <th>Delivery Date</th>
                    <th>Prepared By</th>
                    <th>Status</th>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>

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
                </div>
            </div>

            <div class="panel panel-default col-md-6 pull-right" style="padding-bottom:10px;">
                <div class="panel-body">

                    <div class="form-inline">
                        <label for="drNumber">Delivery Receipt Number</label>
                        <input type="text" class="form-control" name="drNumber" />
                    </div>
                    <br/>

                    <table class="table table-bordered" >
                        <colgroup>
                            <col style="width:60%" />
                        </colgroup>
                        <tr>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Received</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><input type="number" name="received" class="transparentBg inputSize" /></td>
                        </tr>
                    </table>
                    <br/>
                </div>
            </div>

            <!--IF STATEMENT AGAIN HERE-->

            <div class="panel panel-default col-md-6 pull-right">
                <div class="panel-heading">
                    <h3 class="panel-title">Sizes</h3>
                </div>
                <div class="panel-body">
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
                    </table>
                </div>
            </div>

            <!--ELSE HERE-->
            <div class="panel panel-default col-md-6 pull-right">
                <div class="panel-heading">
                    <h3 class="panel-title">Sizes</h3>
                </div>
                <div class="panel-body">
                    <input type="hidden" name="sizeName"  value="" />
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
                    </table>
                </div>
            </div>

        </div>
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-danger">Receive</button>
            <button class="btn btn-danger">Receive All</button>
        </div>
    </body>
</html>
