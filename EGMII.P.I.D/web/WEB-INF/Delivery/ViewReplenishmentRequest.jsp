<%-- 
    Document   : ViewReplenishmentRequest
    Created on : 11 4, 15, 10:06:53 PM
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
        <title>View Replenishment Request</title>
    </head>
    <body>
        <div class="container" align="center">
            <h2>View Replenishment Request</h2>

            <div class="panel panel-default col-md-5" style="padding-bottom:10px; ">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width: 20%" />
                            <col style="width: 10%" />
                            <col style="width: 25%" />
                            <col style="width: 20%" />
                        </colgroup>
                        <tr>
                            <th>Replenishment ID</th>
                            <th>Version</th>
                            <th>Outlet</th>
                            <th>Date Made</th>
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

            <div class="panel panel-default col-md-5" style="padding-bottom:10px;">
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
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-danger">Print</button>
        </div>
    </body>
</html>
