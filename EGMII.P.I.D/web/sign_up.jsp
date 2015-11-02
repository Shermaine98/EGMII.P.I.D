<%-- 
    Document   : sign_up
    Created on : 10 2, 15, 8:13:06 PM
    Author     : Geraldine
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Sign Up</title>

        <style>
            label{
                color: #FFF;
            }
            
            .form-control{
                width:160px;
            }
            label{
                display: inline-block;
                float: left;
                clear: left;
                width: 40%;
                text-align: right;
                margin-right: 10px;
            }
            input {
                display: inline-block;
                float: left;
            }
        </style>

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
                                        <li class="active"><a href="#">Sign Up</a></li>
                                        <li><a href="contact.jsp">Contact</a></li>
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

        <div align="center">
            <div class="container Absolute-Center">
                <br/>
                <h1>SIGN UP</h1>

                <form class="form-inline" role="form" action="SignUp" method="POST" name="sign-up">
                    <label for="firstName">First Name:</label>
                    <input type="text" name="firstName" placeholder="First Name" class="form-control"/><br/><br/>
                    <label for="lastName">Last Name: </label>
                    <input type="text" name="lastName" placeholder="Last Name" class="form-control"/><br/><br/>
                    <label for="email">Email:   </label>
                    <input type="text" name="email" placeholder="Email Address" class="form-control"/><br/><br/>
                    <label for="password">Password: </label>
                    <input type="password" name="newPassword" placeholder="Password" class="form-control"><br/><br/>
                    <label for="birthDate">Birthdate:</label>
                    <input type="date" name="birthDate" class="form-control"/><br/><br/>
                    <label for="verCode"></label>
                    <input type="text" name="verCode" placeholder="Verification Code Here" class="form-control" style=" height:30px;"/><br/>
                    <br/><br/>
                    <input type="submit" name="submit" class="btn btn-danger" value="Sign-up" style="float:none;"/>
                    <a href="redirect.jsp">
                        <button type="button" name="button" class="btn btn-danger"/>Cancel</button></a><br/>
                </form>
            </div>
        </div>


        <!--Footer
        ==========================-->

        <footer>
            <div class="container">
                <div class="row">
                    Copyright &copy 2015 Evergrowth Garments Manufacturing Incorporated | All Rights Reserved <br/>
                    <small>Copyright &copy 2013 Shapebootstrap | All Rights Reserved</small>
                </div>
            </div>
        </footer>

        <!--/.Footer-->

    </body>

</html>
