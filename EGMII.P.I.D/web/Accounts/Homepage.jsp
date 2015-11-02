<%-- 
    Document   : Homepage
    Created on : Oct 8, 2015, 4:07:07 PM
    Author     : shermainesy
--%>

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
                padding-top:100px; padding-left: 50px;
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
                        (('' + month).length < 2 ? '0' : '') + month + '-' +
                        (('' + day).length < 2 ? '0' : '') + day + '-' + d.getFullYear();

                document.getElementById('Today').value = output + "   " + currentTimeString;

            }

            $(document).ready(function ()
            {
                setInterval('updateClock()', 1000);
            });

        </script>
    </head>
    <body>
        <div class="padding">
            <p>Welcome, <%= user.getFirstName()%> <%= user.getLastName()%>! </p>
            <p>Today is  <input type="text" class="transparentBg" id="Today" readonly /></p>
        </div>
    </body>


</html>
