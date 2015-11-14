<%-- 
    Document   : Supplier Purchase Order
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchSupplier.js"></script>
        <script type="text/javascript" src="js/deleteRow.js"></script>
        <script src="js/Validation.js"></script>
        <script src="js/searchWarehouse.js"></script>

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
                        <input type="text" name="poNumber" class="form-control" id="poNumber" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="readonlyWhite" id="preparedBy" value="<%=user.getEmployeeNumber()%>" />
                        <input type="text" class="form-control" readonly value="<%= user.getFirstName()%> <%= user.getLastName()%>" /><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" placeholder="yyyy-mm-dd" class="form-control" id="datepicker" pattern=".{1,}" required title="Please Input Delivery Date" /><br/>
                        <label class="" for="supplier">Supplier</label>
                        <input type="text" name="supplier" class="form-control" id="supplierName" onkeypress="autoCompleteSupplier()" placeholder="Search Supplier" /><br/>
                    </div>
                </div>

                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Details</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <div class="input-group">
                            <input type="text" class="form-control" name="itemNameSupplier" id="itemNameSupplier" onkeypress="autoCompleteSupplierItem()" placeholder="Search Item"/>
                            <span class="input-group-btn">
                                <a href="#" onClick="getSupplierItem()" class="btn btn-default">
                                    <span class="glyphicon glyphicon-search"></span>
                                </a></span>
                        </div>
                        <br/><br/>

                        <table id="data" class="table table-bordered">
                            <tbody id="table">
                            </tbody>
                        </table>

                        <br/>
                        <div id="total1" align="center" style="visibility:hidden;">
                            <div style="float:right">
                                TOTAL:
                                <input type="text" class="form-control" name="Total" id="total" readonly />
                            </div>
                            <br/><br/><br/>
                            <input type="button" class="btn btn-primary" value="Delete Row" onclick="deleteRowSupplier('table')" />

                            <br/><br/>
                            <input type="submit" class="btn btn-default" value="Submit">
                            <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
                        </div>


                    </div>
                </div>
            </form>
        </div>
        <script>


            $(function () {
                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});
            });
            
            $(document).ready(function () {
                var spoNumber = '${SPONumber}';
                document.getElementById('poNumber').value = spoNumber;
            });
        </script>
    </body>
</html>
