<%-- 
    Document   : Homepage
    Created on : Oct 8, 2015, 4:07:07 PM
    Author     : shermainesy
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home | Welcome to Hammerhead!</title>

        <style>
            p{
                font-size: 40px;
            }
            .padding{
                margin-top: 50px;
                padding-top: 100px;
            }
            .alert{
                padding-top: 30px;
                padding-bottom: 30px;
            }
        </style>
        <script>
            function updateClock( )
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
                        (('' + month).length < 2 ? '0' : '') + month + '/' +
                        (('' + day).length < 2 ? '0' : '') + day + '/' + d.getFullYear();

                document.getElementById('Today').value = output;

            }

            $(document).ready(function ()
            {
                setInterval('updateClock()', 1000);
            });

        </script>
    </head>
    <body>
        <div class="padding">
            <div class="pull-left" style="width:50%; margin-left:90px; ">
                <p>Welcome, <%= user.getFirstName()%> <%= user.getLastName()%>! </p>
                <p>Today is  <input type="text" class="transparentBg" id="Today" readonly /></p>
            </div>
            <div class="pull-right" style="width:30%; margin-right:90px;">
                <% boolean notif = (boolean) request.getAttribute("Notification");
                    if (notif) {
                        if (user.getPosition().equalsIgnoreCase("general manager")) {
                            int spo = (int) request.getAttribute("Gen1");
                            int subpo = (int) request.getAttribute("Gen2");
                %>
                <div class="alert alert-danger" role="alert">
                    <%=spo%> Supplier Purchase Orders Need Approval<br/>
                    <%=subpo%> Subcontractor Purchases Order Need Approval
                </div>
                <!--End of if gen man-->
                <% } else if (user.getPosition().equalsIgnoreCase("production manager")) {
                    int prod = (int) request.getAttribute("prodman");
                %>
                <div class="alert alert-danger" role="alert">
                    <%=prod%> Subcontractor Purchase Orders To Be Received
                </div>
                <!--End of Production Manager-->
                <% } else if (user.getPosition().equalsIgnoreCase("cutting master")) {
                    int cutting = (int) request.getAttribute("Cut");
                %>
                <div class="alert alert-danger" role="alert">
                    There are currently <%=cutting%> Consumption Reports
                </div>
                <!--End of Cutting Master-->
                <% } else if (user.getPosition().equalsIgnoreCase("warehouse manager")) {
                    int warehouse = (int) request.getAttribute("Warehouse");%>
                <div class="alert alert-danger" role="alert">
                    There are currently <%=warehouse%> that are Out of Stock
                </div>
                <!--End of Warehouse Manager //-->
                <% } else if (user.getPosition().equalsIgnoreCase("promoter")) {
                    int promo = (int) request.getAttribute("Promo");%>
                <div class="alert alert-danger" role="alert">
                     <%=promo%> New Inventory Reports
                </div>
                <!--End of Promo-->
                <% } else if (user.getPosition().equalsIgnoreCase("promoter supervisor")) {
                    ArrayList<Date> promo = (ArrayList<Date>) request.getAttribute("Promo Sup");%>
                <div class="alert alert-danger" role="alert">
                     A new delivery invoice is coming on <%=promo.toString() %>
                </div>
                <!--End of Promo Supervisor-->
                <% } else if (user.getPosition().equalsIgnoreCase("receipt handler")) {
                    int rec = (int) request.getAttribute("receipth");%>
                <div class="alert alert-danger" role="alert">
                     <%=rec %> Replenishment Reports to be Scheduled
                </div>
                <!--End of Receipt Handler-->
                <% } else if (user.getPosition().equalsIgnoreCase("assistant production manager")) {
                    int rec = (int) request.getAttribute("apm");%>
                <div class="alert alert-danger" role="alert">
                     <%=rec %> Supplier Purchase Orders To Be Received
                </div>
                <!--End of Assistant Production Manager-->
                <% } %>
                <!--End of Main IF--> 
                <% } else { %>
                <div class="alert alert-success" role="alert">All done!</div>
                <!--End of Main Else-->
                <% }%>
            </div>
        </div>
    </body>


</html>
