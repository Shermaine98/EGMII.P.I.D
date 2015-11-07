<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.SupplierPurchaseOrderView"%>
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
        <title>View Supplier Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });
                
                
               $(".SPO").on("click", (function () {
                var productionNumber = $(this).closest("tr").find(".poNumber").text();
                document.getElementById('hiddenValue').value = productionNumber;
                document.getElementById("form1").submit();
            }));
            });
            
        </script>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>View Supplier Purchase Order</h2></center>

    <br/><br/>
    <%        
    String data = (String) request.getAttribute("data");
    ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrder");
    %>
    <form form="1" method="post" action="ViewSupplierPurchaseOrderServlet">
    <div align="center" class="container">
        <table id="dataTable" class="table table-bordered" style="width:80%">
            <thead>
                <tr>
                    <th>Purchase Order Number</th>
                    <th>Item Number</th>
                    <th>Supplier</th>
                    <th>Volume Quantity</th>
                    <th>Data Made</th>
                    <th>Delivery Date</th>
                    <th>Prepared By</th>
                    <th>Approved By</th>
                    <th>Receiving Status</th>
                    <th>Reconcile Status</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (int i = 0; i < SupplierPurchaseOrderList.size(); i++) {
                %> 
                <tr clas="SPO">
                    <td clas="poNumber"><%= SupplierPurchaseOrderList.get(i).getPoNumber()%></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getCompanyName()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getDateMade()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getDeliveryDate()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getPreparedBy()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getApprovedBy()%>"/></td>        
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
             <input type="hidden" name="poNumber" id="hiddenValue" value=""/>
    </div>
     </form>
            
            
      <div>
        <%
         if (data.equalsIgnoreCase("SupplierPurchaseOrderSpecific")) {
            ArrayList<SupplierPurchaseOrderView> spo1 = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderSpecific");

        %>
        <!--Consumption Report View From Encode of Bill of Materials-->

        <table><td><%= spo1.get(0).getPoNumber()%></td></table>
                <%
                    }
                %>
                <br/><br/>
        </div>
    <script></script>
</body>

</html>
