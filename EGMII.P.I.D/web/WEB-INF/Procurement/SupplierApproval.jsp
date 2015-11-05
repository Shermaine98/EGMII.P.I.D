<%-- 
    Document   : Approval
    Created on : 11 4, 15, 10:58:14 AM
    Author     : Geraldine
--%>

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
        <title>Supplier Purchase Order Approval</title>
        
    </head>
    <body>
        <div class="container" align="center">
            <h2>Approve Supplier Purchase Order</h2><br/>

            <table class="table table-bordered" style="width:60%;">
                <colgroup>
                    <col style="width:23%" />
                    <col style="width:35%" />
                </colgroup>
                <tr>
                    <th>Purchase Order No.</th>
                    <th>Supplier</th>
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
                <div class="panel panel-default col-md-4 pull-left" style="padding-bottom:10px;">
                    <div class="panel-body">
                        <label for="poNumber">Purchase Order No.</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="poNumber" />
                        <label for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="preparedBy" />
                        <label for="dateMade">Date Made</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="dateMade" />
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="date" class="form-control" id="datepicker" name="deliveryDate" />
                        <label for="supplier">Supplier</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="supplier" />
                    </div>
                </div>
                <div class="panel panel-default col-md-6" style="padding-top: 10px;">
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>Item Name</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>

                        <div class="form-inline pull-right">
                            <label for="total">Total:</label>
                            <input type="number" class="form-control readonlyWhite" name="total" readonly /> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="buttonz" align="center">
            <!--Buttons-->
            <input type="button" value="Approve" class="btn btn-danger" />
            <button class="btn btn-danger">Reject</button><br/><br/>
            <button class="btn btn-danger">Print</button>
        </div>
    </body>
</html>
