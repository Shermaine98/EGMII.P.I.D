<%-- 
    Document   : Receipt Handler Naviagtion Bar
    Created on : Dec 4, 2014, 7:36:40 PM
    Author     : Atayan, Lapidario, Sy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <body>
        <!--Bootstrap core CSS--> 
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="bootstrap/css/bootstrap-theme.min.css" rel="stylesheet">

        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-left" style="padding-right: 7px"><img src="Images/hhlogo.png" height="50" width="50"></a>
                    <a class="navbar-brand" href="#">Hammerhead</a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="dashboard.jsp">Dashboard</a></li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Delivery Order <span class="caret"></span></a> <ul class="dropdown-menu" role="menu">
                                <li><a href="EndcodeDeliveryOrder.jsp">Create Delivery Order</a></li>
                                <li><a href="ViewDeliveryOrder.jsp">View Delivery Order</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Delivery Receipt <span class="caret"></span></a> <ul class="dropdown-menu" role="menu">
                                <li><a href="EndcodeDeliveryReceipt.jsp">Create Delivery Receipt</a></li>
                                <li><a href="ViewDeliveryReceipt.jsp">View Delivery Receipt</a></li>
                            </ul>
                        </li>
                        <li><a href="jsp">Receive Picking Form Alert</a></li>
                    </ul>

                    <!-- end of leftnavbar. start of right navbar -->
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="https://mail.google.com/"><span class="glyphicon glyphicon-envelope"></span> Mail </a></li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-list-alt"></span> Notification<b class="caret"></b></a>
                            <ul class="dropdown-menu alert-dropdown">
                                <li><a href="#">Alert Name <span class="label label-default">Alert Badge</span></a></li>
                                <li><a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a></li>
                                <li><a href="#">Alert Name <span class="label label-success">Alert Badge</span></a></li>
                                <li><a href="#">Alert Name <span class="label label-info">Alert Badge</span></a></li>
                                <li><a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a></li>
                                <li><a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a></li>
                                <li class="divider"></li>
                                <li><a href="#">View All</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> Account<span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="myaccount.jsp">View Account</a></li>
                                <li><a href="editaccount.jsp">Edit Account</a></li>
                                <li><a href="index.jsp">Log-Out</a></li>
                            </ul>
                        </li>
                    </ul>

                </div><!--/.nav-collapse -->
            </div>
        </nav>
        <script src="bootstrap/js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </body>

</html>