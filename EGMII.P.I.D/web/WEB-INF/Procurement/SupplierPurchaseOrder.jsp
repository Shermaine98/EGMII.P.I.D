<%-- 
    Document   : Supplier Purchase Order
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.SupplierPurchaseOrder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/jquery-ui-datePicker.css">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/searchStyle.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.mockjax.js"></script>
        <script type="text/javascript" src="js/jquery.autocomplete.min.js"></script>
        <script type="text/javascript" src="bootstrap/js/jquery-ui.js"></script>
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchSupplier.js"></script>
        <script src="js/deleteRow.js"></script>
        <script src="bootstrap/js/jquery-ui.js"></script>
        <title>Encode Supplier Purchase Order</title>
        <script>
            $(document).ready(function () {
                var spoNumber = '${SPONumber}';
                document.getElementById('poNumber').value = spoNumber;

            });
        </script>
    </head>
    <body>  
        <br/>
        <div align="center" class="container-fluid" style="margin-left:40px; margin-right:20px;">
            <h2>Encode Supplier Purchase Order</h2><br/>
            <form method="POST" action="EncodeSupplierPurchaseOrderServlet">

                <div class="panel panel-default col-md-4">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control readonlyWhite" id="poNumber" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="form-control readonlyWhite" id="preparedBy" value="<%= user.getEmployeeNumber()%>" />
                        <input type="text" class="form-control readonlyWhite" readonly value="<%= user.getFirstName()%> <%= user.getLastName()%>" /><br/>
                        <label class="" for="deliveryDate">Delivery</label>
                        <input type="text" name="deliveryDate" class="form-control readonlyWhite" id="datepicker" readonly /><br/>
                        <label class="" for="supplier">Supplier</label>
                        <input type="text" name="supplier" class="form-control" id="supplierName" onkeypress="autoCompleteSupplier()" placeholder="Search Supplier" /><br/>
                        <input type="hidden" name="supplier" id ="supplierName" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body">

                        <div class="input-group">
                            <input type="text" class="form-control" name="itemNameSupplier" id="itemNameSupplier" onkeypress="autoCompleteSupplierItem()" placeholder="Search Item"/>
                            <input type="hidden" name="itemNameSupplier" id="itemNameSupplier" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                            <span class="input-group-btn">
                                <a href="#" onClick="getSupplierItem()" class="btn btn-default">
                                    <span class="glyphicon glyphicon-search"></span>
                                </a></span>
                        </div>
                        <br/><br/>

                        <table id="data" class="table table-bordered">
                        </table>

                        <div id="total" align="center" style="visibility:hidden;">
                            <div style="float:right">
                            TOTAL:
                            <input type="text" class="form-control readonlyWhite" name="Total1" id="total1" readonly />
                            </div>
                            <br/><br/><br/>
                            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('data')" />

                            <br/><br/>
                            <input type="submit" class="btn btn-danger" value="Submit">
                            <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>

                        </div>


                    </div>
                </div>
            </form>
        </div>
        <script>
            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

            });
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
