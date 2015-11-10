<%-- 
    Document   : ApproveInvoice
    Created on : 11 4, 15, 10:58:24 PM
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
         <script src="js/Validation.js"></script>
        <title>Approve Invoice</title>
    </head>
    <body>
        <div class="container" align="center">
            <h2>Approve Invoice</h2><br/>

            <table class="table table-bordered" style="width:50%;">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:23%" />
                    <col style="width:20%" />
                    <col style="width:20%" />
                </colgroup>
                <tr>
                    <th>Invoice No.</th>
                    <th>Branch</th>
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


            <div class="panel panel-default col-md-3" style="padding-bottom:10px; margin-left: 60px;">
                <div class="panel-body">
                    <label for="invoiceNum">Invoice Number</label>
                    <input type="text" class="form-control" readonly name="invoiceNum" value="" /><br/>
                    <label for="preparedBy">Prepared By</label>
                    <input type="text" class="form-control " readonly name="preparedBy" value="" /><br/>
                    <label for="dateMade">Date Made</label>
                    <input type="text" class="form-control " readonly name="dateMade" value="" /><br/>
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="text" class="form-control " readonly name="deliveryDate" value="" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control " readonly name="promo" value="" /><br/>
                    <label for="branch">Branch</label>
                    <input type="text" class="form-control " readonly name="branch" value="" /><br/>
                    <label for="address">Address</label>
                    <input type="text" class="form-control " readonly name="address" value="" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7" style="padding-top:10px;padding-bottom:5px;">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Product Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Quantity</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
        <br/>
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-default">Approve</button>
            <button class="btn btn-primary">Reject</button><br/><br/>
            <button class="btn btn-default" style="width:130px">Approve & Print</button>
        </div>
    </body>
</html>
