<%-- 
    Document   : SupplierPurchaseOrder
    Created on : 11 4, 15, 10:21:39 AM
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
        <link rel="stylesheet" href="bootstrap/css/jquery-ui-datePicker.css">
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchSupplier.js"></script>
        <script src="js/deleteRow.js"></script>

        <style>
            .input{
                width:25px;
            }
        </style>
        <title>Encode Supplier Purchase Order</title>
    </head>
    <body>
        <div align="center" class="container">
            <h2>Encode Supplier Purchase Order</h2><br/>
            <form method="POST" action="EncodeSupplierPurchaseOrderServlet">

                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Supplier Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control readonlyWhite" id="poNumber" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="form-control readonlyWhite" id="preparedBy" value="<%=user.getEmployeeNumber()%>" />
                        <input type="text" class="form-control readonlyWhite" readonly value="<%= user.getFirstName()%> <%= user.getLastName()%>" /><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" class="form-control" id="datepicker" pattern=".{1,}" required title="Please Input Delivery Date" /><br/>
                        <label class="" for="supplier">Supplier</label>
                        <input type="text" name="supplier" class="form-control" id="supplierName" onkeypress="autoCompleteSupplier()" placeholder="Search Supplier" /><br/>
                        <input type="hidden" name="supplier" id ="supplierName" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Details</h3>
                    </div>
                    <div class="panel-body table-responsive">
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

                        <br/>
                        <div id="total1" align="center" style="visibility:hidden;">
                            <div style="float:right">
                                TOTAL:
                                <input type="text" class="form-control readonlyWhite" name="Total" id="total" readonly />
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

            $(document).ready(function () {
                var spoNumber = '${SPONumber}';
                document.getElementById('poNumber').value = spoNumber;

            });
        </script>
    </body>
</html>
