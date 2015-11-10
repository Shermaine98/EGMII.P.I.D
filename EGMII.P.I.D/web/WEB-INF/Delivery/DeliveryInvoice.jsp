<%-- 
    Document   : DeliveryInvoice
    Created on : 11 4, 15, 10:30:07 PM
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
        <title>Delivery Invoice</title>
    </head>
    <body>
        <div class="container" align="center">
            <h2>Delivery Invoice</h2>

            <div class="panel panel-default col-md-3" style="padding-bottom:10px; margin-left: 60px;">
                <div class="panel-body">
                    <label for="invoiceNum">Invoice No.</label>
                    <input type="text" class="form-control " readonly name="invoiceNum" value="" /><br/>
                    <label for="preparedBy">Prepared By</label>
                    <input type="text" class="form-control " readonly name="preparedBy" value="" /><br/>
                    <label for="dateMade">Date Made</label>
                    <input type="text" class="form-control " readonly name="dateMade" value="" /><br/>
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="text" class="form-control" id="datepicker"  name="deliveryDate" value="" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control " readonly name="promo" value="" /><br/>
                    <label for="branch">Branch</label>
                    <input type="text" class="form-control " readonly name="branch" value="" /><br/>
                    <label for="address">Address</label>
                    <input type="text" class="form-control " readonly name="address" value="" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7" style="padding-bottom:10px;">
                <div class="panel-body">

                    <!--SEARCH BOX COPY PASTE HERE?-->

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
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-default">Submit</button>
            <button class="btn btn-primary">Cancel</button>
        </div>

        <script>
            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });
        </script>

    </body>
</html>
