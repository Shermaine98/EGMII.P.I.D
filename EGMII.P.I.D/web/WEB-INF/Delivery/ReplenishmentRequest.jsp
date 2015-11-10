<%-- 
    Document   : ReplenishmentRequest
    Created on : 11 4, 15, 10:06:53 PM
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
        <title>Replenishment Request</title>
        <style>
        </style>
    </head>
    <body>
        <div class="container" align="center">
            <h2>Replenishment Request</h2>

            <div class="panel panel-default col-md-3">
                <div class="panel-body">
                    <label for="outlet">Outlet</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="outlet" value="" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="promo" value="" /><br/>
                    <label for="date">Date</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="date" value="" /><br/>
                    <label for="repID">Replenishment ID</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="repID" value="" /><br/>
                    <label for="version">Version</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="version" value="" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Product Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Quantity</th>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" class="transparentBg" name="productName" />  
                            </td>
                            <td>
                                <select name="color" class="transparentBg">
                                    <option value="sample">Sample</option>
                                </select>  
                            </td>
                            <td>
                                <select name="size" class="transparentBg">
                                    <option value="sample">Sample</option>
                                </select>  
                            </td>
                            <td>
                                <input type="number" class="transparentBg inputSize" name="quantity" />  
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-danger">Save</button>
            <button class="btn btn-danger">Cancel</button><br/><br/>
            <button class="btn btn-danger" style="width:140px">Print Picking Form</button>
        </div>
    </body>
</html>
