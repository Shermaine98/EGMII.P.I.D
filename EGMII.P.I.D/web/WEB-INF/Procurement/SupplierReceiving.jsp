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
            <h2>Supplier Purchase Order Receiving</h2><br/>

            <table class="table table-bordered" style="width:60%;">
                <colgroup>
                    <col style="width:23%" />
                    <col style="width:30%" />

                </colgroup>
                <tr>
                    <th>Purchase Order No.</th>
                    <th>Supplier</th>
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
                    <label for="supplier">Supplier</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="supplier" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-6 pull-left" style="padding-bottom:10px;">
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
        </div>

        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-danger">Receive</button>
            <button class="btn btn-danger">Receive All</button>
        </div>
    </body>
</html>
