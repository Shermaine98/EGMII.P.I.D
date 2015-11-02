<%-- 
    Document   : contact
    Created on : 11 2, 15, 1:30:27 PM
    Author     : Geraldine
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Contact Us</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Bootstrap -->
        <link href="bootstrap/Fornax/css/bootstrap.css" rel="stylesheet">
        <link href="bootstrap/Fornax/css/bootstrap-responsive.css" rel="stylesheet">
        <link href="bootstrap/Fornax/css/style.css" rel="stylesheet"> 
        <link href="bootstrap/css/EGMI-style-home.css" rel="stylesheet" type="text/css">

        <!--Font-->
        <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600' rel='stylesheet' type='text/css'>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- SCRIPT 
        ============================================================-->  
        <script src="bootstrap/js/jquery.js"></script>
        <script src="bootstrap/js/bootstrap.js"></script>
    </head>
    <body>
        <!--HEADER ROW-->
        <div id="header-row">
            <div class="container">
                <div class="row">
                    <!--LOGO-->
                    <div class="span3"><a class="brand" href="#"><img src="Images/logo.png"/></a></div>
                    <!-- /LOGO -->

                    <!-- MAIN NAVIGATION -->  
                    <div class="span9">
                        <div class="navbar  pull-right">
                            <div class="navbar-inner">
                                <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></a>
                                <div class="nav-collapse collapse navbar-responsive-collapse">
                                    <ul class="nav">
                                        <li><a href="index.jsp">Home</a></li>
                                        <li><a href="sign_up.jsp">Sign Up</a></li>
                                        <li class="active"><a href="#">Contact</a></li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- MAIN NAVIGATION -->  
                </div>
            </div>
        </div>
        <!-- /HEADER ROW -->

        <div align="center" class="container Absolute-Center">
            <h1>Contact Us</h1>
            <br/>
            <div style="float:left">
                <p>Marielle Lapidario <br/>
                    marielle_lapidario@dlsu.edu.ph<br/>
                    +639062788726 <br/><br/>

                    Shermaine Sy <br/>
                    shermaine_sy@dlsu.edu.ph <br/>
                    +639175606705</p>
            </div>
            <div style="float:right">
                <p>
                    Geraldine Atayan<br/>
                    geraldine_atayan@dlsu.edu.ph<br/>
                    +639277289041<br/><br/>

                    Elvyne Dimaandal<br/>
                    andrian_dimaandal@dlsu.edu.ph<br/>
                    +639772191613
                </p>
            </div>
        </div>


        <!--Footer
        ==========================-->

        <footer >
            <div class="container">
                <div class="row">
                    Copyright &copy 2015 Evergrowth Garments Manufacturing Incorporated | All Rights Reserved <br>
                    <small>Copyright &copy 2013 Shapebootstrap | All Rights Reserved</small>
                </div>
            </div>
        </footer>

        <!--/.Footer-->

    </body>
</html>
