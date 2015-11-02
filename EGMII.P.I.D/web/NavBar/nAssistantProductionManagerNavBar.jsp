<%-- 
    Document   : AssitantProductionManagerNavBar
    Created on : Aug 20, 2015, 7:15:16 PM
    Author     : shermainesy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!--JQUERY LIBRARIES-->
        <script type="text/javascript" src="bootstrap/js/jquery.js"></script>
        <script type="text/javascript" src="bootstrap/js/jquery-ui.js"></script>
        <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-left"><img src="Images/hhlogo.png" height="50" width="50"></a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li> <a href="/EGMI/Login?action=goToHome">Home</a></li>
                        <!--Procurement-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Procurement
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="">Supplier Purchase Order</a>
                                    <ul class="dropdown-menu sub-menu">
                                        <li><a href="/EGMI/SetSPOServlet">Encode Supplier Purchase Order</a></li>
                                        <li><a href="/EGMI/ViewSupplierPurchaseOrderServlet">View Supplier Purchase Order</a></li></ul></li>

                                <li><a href="/EGMI/PurchaseOrderSerlvet">Receiving</a></li>
                            </ul>
                        </li>
                        
                        <!--Vendor-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Vendor
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="/EGMI/ViewSuppliersAndItemServlet">Suppliers</a></li>
                                <li><a href="/EGMI/ViewSubcontractorAndServiceServlet">Subcontractor</a></li>
                            </ul>
                        </li>
                        
                        <li><a href="">Reconcile Alert</a></li>
                    </ul>

                    <!--MAIL-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>Today is <input type="text" class="transparentBg" name="dateMade" id="dateMade" readonly 
                                            style="height: 50px; 
                                            line-height: 15px;" /></li>
                        <li><a href="https://mail.google.com/"><span class="glyphicon glyphicon-envelope"></span></a></li>
                        <!--ACCOUNT DETAILS-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user"></span>
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="/EGMI/Login?action=viewAccounts">View Account</a></li>
                                <li><a href="/EGMI/Logout">Log-Out</a></li>
                            </ul>
                        </li>
                    </ul>

                </div><!--/.nav-collapse -->
            </div>
        </nav>
        <script>
            function updateClock1( )
            {
                var currentTime = new Date( );
                var currentHours = currentTime.getHours( );
                var currentMinutes = currentTime.getMinutes( );
                var currentSeconds = currentTime.getSeconds( );

                // Pad the minutes and seconds with leading zeros, if required
                currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
                currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

                // Choose either "AM" or "PM" as appropriate
                var timeOfDay = (currentHours < 12) ? "AM" : "PM";

                // Convert the hours component to 12-hour format if needed
                currentHours = (currentHours > 12) ? currentHours - 12 : currentHours;

                // Convert an hours component of "0" to "12"
                currentHours = (currentHours == 0) ? 12 : currentHours;

                // Compose the string for display
                var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;

                var d = new Date();
                var month = d.getMonth() + 1;
                var day = d.getDate();
                var output =
                        (('' + month).length < 2 ? '0' : '') + month + '-' +
                        (('' + day).length < 2 ? '0' : '') + day + "-" + d.getFullYear();
                document.getElementById('dateMade').value = output + "   " + currentTimeString;

            }

            $(document).ready(function ()
            {
                setInterval('updateClock1()', 1000);
                // TODO:  $('[data-toggle="popover"]').popover();   
            });

        </script>
    </body>
</html>
