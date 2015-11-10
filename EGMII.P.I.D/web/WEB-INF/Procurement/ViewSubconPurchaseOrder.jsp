<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.SubconPurchaseOrderView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
         <script src="js/Validation.js"></script>
        <title>View Subcontractor Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });
            });
        </script>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>View Subcontractor Purchase Order</h2></center>

    <br/><br/>
    <%        ArrayList<SubconPurchaseOrderView> SubconPurchaseOrderList = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("SubconPurchaseOrderList");
        if (!SubconPurchaseOrderList.isEmpty()) {
    %>
    <div align="center" class="container" style="width:80%">
        <table id="dataTable" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Purchase Order Number</th>
                    <th>Production Number</th>
                    <th>Product ID</th>
                    <th>Size Type</th>
                    <th>Subcontractor</th>
                    <th>Service</th>
                    <th>Date Made</th>
                    <th>Delivery Date</th>
                    <th>Prepared By</th>
                    <th>Approved By</th>
                    <th>Receiving Status</th>
                    <th>Reconcile Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (int i = 0; i < SubconPurchaseOrderList.size(); i++) {
                %> 
                <tr>
                    <td><input type="text" value="<%= SubconPurchaseOrderList.get(i).getPoNumber()%>"/></td>
                    <td><input type="text" value="<%= SubconPurchaseOrderList.get(i).getProductionNumber()%>"/></td>
                    <td><input type="text" value="<%= SubconPurchaseOrderList.get(i).getDateMade()%>"/></td>
                    <td><input type="text" value="<%= SubconPurchaseOrderList.get(i).getDeliveryDate()%>"/></td>
                    <td><input type="text" value="<%= SubconPurchaseOrderList.get(i).getPreparedBy()%>"/></td>                 
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <%}%>
    <script></script>
</body>

</html>
