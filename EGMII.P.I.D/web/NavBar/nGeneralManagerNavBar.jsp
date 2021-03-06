<%-- 
    Document   : AssitantProductionManagerNavBar
    Created on : Aug 20, 2015, 7:15:16 PM
    Author     : shermainesy
--%>

<%@page import="Model.User"%>
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
        <link rel="stylesheet" href="bootstrap/css/searchStyle.css">
        <link rel="stylesheet" href="bootstrap/css/jquery-ui-datePicker.css">
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
                        <li> <a href="/EGMII.P.I.D/Account?action=goToHome">Home</a></li>
                        <!--Product Creation-->
                        <li class="dropdown">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">Product Creation
                                <span class="caret"></span></a> 

                            <ul class="dropdown-menu" role="menu">
                                <!--SUB-MENU OF BILL OF MATERIALS-->
                                <li>
                                    <a href="/EGMII.P.I.D/SetProductIDServlet">Bill Of Materials</a>
                                </li>

                                <!--SUB-MENU OF CONSUMPTION REPORT-->
                                <li><a href="">Consumption Report</a>
                                    <ul class="dropdown-menu sub-menu" style="margin-top: 35px;">
                                        <li><a href="/EGMII.P.I.D/SearchProductServlet?action=Encode">Encode Consumption Report</a></li>
                                        <li><a href="/EGMII.P.I.D/ViewConsumptionReportServlet?goToC=View">View Consumption Report</a></li></ul>
                                </li>

                            </ul>
                        </li>

                        <!--Procurement-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Procurement
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="">Supplier Purchase Order</a>
                                    <ul class="dropdown-menu sub-menu">
                                          <li><a href="/EGMII.P.I.D/SetSPONumberServlet?action=create">Encode Supplier Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/ApproveSupplierPurchaseOrderServlet?action=approve">Approve Supplier Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/ViewSupplierPurchaseOrderServlet">View Supplier Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/SetSupplierReceivingServlet?action=receive">Receive Supplier Purchase Order</a></li></ul></li>

                                <li><a href="">Subcontractor Purchase Order</a>
                                    <ul class="dropdown-menu sub-menu" style="margin-top: 35px;">
                                        <li><a href="/EGMII.P.I.D/SetSubconNumberServlet?action=create">Encode Subcontractor Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/ApproveSubconPurchaseOrderServlet?action=approve">Approve Subcontractor Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/ViewSubconPurchaseOrderServlet?action=view">View Subcontractor Purchase Order</a></li>
                                        <li><a href="/EGMII.P.I.D/SetSubconPOReceivingServlet?action=view">Receive Subcontractor Purchase Order</a></li></ul></li>

                                <li><a href="/EGMII.P.I.D/GenerateCuttingReportServlet">Generate Cutting Report</a></li>
                            </ul>
                        </li>

                        <!--Inventory-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inventory
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                 <li><a href="/EGMII.P.I.D/ViewAllInventoryServlet">View All Inventory</a></li>
                                <li><a href="/EGMII.P.I.D/ViewBoutiqueInventoryServlet">Boutique Inventory</a></li>
                            </ul>
                        </li>

                        <!--DELIVERY-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Delivery
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Delivery Invoice</a>
                                    <ul class="dropdown-menu sub-menu">
                                        <li><a href="/EGMII.P.I.D/ViewDeliveryInvoiceServlet?action=create">Encode Delivery Invoice</a></li>
                                        <li><a href="/EGMII.P.I.D/ViewDeliveryInvoiceServlet?action=approve">Approve Delivery Invoice</a></li>
                                        <li><a href="/EGMII.P.I.D/ViewDeliveryInvoiceServlet?action=view">View Delivery Invoice</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        
                        <!--Vendor-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Vendor
                                <span class="caret"></span></a> 
                            <ul class="dropdown-menu" role="menu">
                                <li>
                                    <a href="/EGMII.P.I.D/ViewSupplierServlet?action=view">Supplier</a>
                                </li>
                                <li>
                                    <a href="/EGMII.P.I.D/ViewSubconServlet?action=view">Subcontractor</a>
                                </li>
                            </ul>
                        </li>
                        
                    </ul>


                   <%  User user = (User) session.getAttribute("login");
                        String position = user.getPosition().toLowerCase().trim();%> 
                    <!--MAIL-->
                    <ul class="nav navbar-nav navbar-right">
                        <li>Today is <input type="text" class="transparentBg" name="dateMade" id="dateMade" readonly 
                                            style="height: 50px; 
                                            line-height: 15px;" /></li>
                        <li><a href="https://mail.google.com/"><span class="glyphicon glyphicon-envelope"></span></a></li>
                        <!--ACCOUNT DETAILS-->
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user"></span> <%= user.getFirstName()%> <%=user.getLastName()%>
                                <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="/EGMII.P.I.D/Account?action=viewAccounts">View Account</a></li>
                                <li><a href="/EGMII.P.I.D/Logout">Sign Out</a></li>
                            </ul>
                        </li>
                    </ul>

                </div>
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
