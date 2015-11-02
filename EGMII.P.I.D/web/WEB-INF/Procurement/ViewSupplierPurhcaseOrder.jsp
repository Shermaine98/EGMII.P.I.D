<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.SupplierPurchaseOrder"%>
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
            });
        </script>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>View Supplier Purchase Order</h2></center>

    <br/><br/>
    <%        
    ArrayList<SupplierPurchaseOrder> SupplierPurchaseOrderList = (ArrayList<SupplierPurchaseOrder>) request.getAttribute("SupplierPurchaseOrderList");
    %>
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
                <tr>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getPoNumber()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getItemCode()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getSupplier()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getVolumeQty()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getDateMade()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getDeliveryDate()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getPreparedBy()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getApprovedBy()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getReceivingStatus()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getReconcileStatus()%>"/></td>
                    <td><input type="text" value="<%= SupplierPurchaseOrderList.get(i).getNote()%>"/></td>                   
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
    <script></script>
</body>

</html>
