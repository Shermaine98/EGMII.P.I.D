<%-- 
    Document   : ViewAccount
    Created on : Oct 25, 2015, 4:57:39 PM
    Author     : shermainesy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
        <style>
            h1 {
                font-size: 50px;
                font-weight: bold;
            }
            .container{
                margin-top:50px;
                background-color: #f2f2f2;
                padding: 30px;
                width: 50%;
            }
            .transparentBg{
                background-color: transparent;
                border: 0px;
                outline: none;
                -webkit-box-shadow: none;
                -moz-box-shadow: none;
                box-shadow: none;
                cursor:default;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div align="center">
                <h1><%= user.getFirstName()%> <%= user.getLastName()%></h1>
                <h2><%= user.getEmail()%></h2>
                <br/>
                <br/>
                <button class="btn btn-default" data-toggle="modal" data-target="#myModal">Change Password</button>

                <!-- Modal -->
                <div id="myModal" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <form method="POST" action="ChangePassword">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title">Change Password</h4>
                                </div>

                                <div class="modal-body" style="width:60%">
                                    <p align="left"><b>Email:</b> <input class=" transparentBg" readonly id="email" name="email" value="<%= user.getEmail()%>" /></p><br/>
                                    <label for="current">Current Password:</label>
                                    <input type="password" class="form-control" id="current" name="current" />
                                    <label for="changepass">New Password:</label>
                                    <input type="password" class="form-control" id="changepass" name="changepass" />
                                </div>

                                <div class="modal-footer">
                                    <input type="submit" class="btn btn-default" />
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>
    </body>
</html>
