<%-- 
    Document   : InventoryReport
    Created on : 11 4, 15, 9:47:18 PM
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
        <title>Inventory Report</title>
    </head>
    <body>

        <div class="container" align="center">

            <h2>Inventory Report</h2>

            <div class="panel panel-default col-md-3 pull-left" style="padding-bottom:10px; margin-left: 60px;">
                <div class="panel-heading">
                    <h3 class="panel-title">Inventory Report</h3>
                </div>
                <div class="panel-body">
                    <label for="outlet">Outlet</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="outlet" value="" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="promo" value="" /><br/>
                    <label for="date">Date</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="date" value="" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-6" style="padding-bottom: 10px;">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width:25%" />
                        </colgroup>
                        <tr>
                            <th>Product Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Beginning Inventory</th>
                            <th>Pulled Out</th>
                            <th>Sold Out</th>
                            <th>Ending Inventory</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
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
            <button class="btn btn-danger">Send</button>
            <button class="btn btn-danger">Cancel</button>
        </div>
    </body>
</html>
