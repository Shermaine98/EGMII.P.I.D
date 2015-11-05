<%-- 
    Document   : Approval
    Created on : 11 4, 15, 10:58:14 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.SupplierPurchaseOrderView"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap/css/table-design.css">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="bootstrap/css/sub-menu.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <title>Supplier Purchase Order Approval</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });

                $(".SupplierPOView").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    var l = document.getElementById('hiddenValue').value;
                    console.log(l);

                    document.getElementById("form1").submit();

                }));
            });
        </script>
    </head>
    <%        ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderList");
    %>
    <body>
        <div class="container" align="center">
            <h2>Approve Supplier Purchase Order</h2><br/>
            <div style="width:60%;">
                <table id="dataTable" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Purchase Order No.</th>
                            <th>Supplier</th>
                            <th>Date Made</th>
                            <th>Delivery Date</th>
                            <th>Prepared By</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < PurchaseOrderList.size(); i++) {%>
                        <tr class="SupplierPOView">
                            <td class="poNumber"><%=PurchaseOrderList.get(i).getPoNumber()%></td>
                            <td><%=PurchaseOrderList.get(i).getCompanyName()%></td>
                            <td><%=PurchaseOrderList.get(i).getDateMade()%></td>
                            <td><%=PurchaseOrderList.get(i).getDeliveryDate()%></td>
                            <td><%=PurchaseOrderList.get(i).getPreparedBy()%></td>
                        </tr>

                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
        </div>
        <%
            String data = (String) request.getAttribute("data");
            if (!data.equalsIgnoreCase("null")) {
        %>

        <div class="container" align="center">
            <div class="panel panel-default col-md-4 pull-left" style="padding-bottom:10px;">
                <div class="panel-body">
                    <label for="poNumber">Purchase Order No.</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="poNumber" />
                    <label for="preparedBy">Prepared By</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="preparedBy" />
                    <label for="dateMade">Date Made</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="dateMade" />
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="date" class="form-control" id="datepicker" name="deliveryDate" />
                    <label for="supplier">Supplier</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="supplier" />
                </div>
            </div>
            <div class="panel panel-default col-md-6" style="padding-top: 10px;">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Item Name</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>

                    <div class="form-inline pull-right">
                        <label for="total">Total:</label>
                        <input type="number" class="form-control readonlyWhite" name="total" readonly /> 
                    </div>
                </div>
            </div>
        </div>
        <div id="buttonz" align="center">
            <!--Buttons-->
            <input type="button" value="Approve" class="btn btn-danger" />
            <button class="btn btn-danger">Reject</button><br/><br/>
            <button class="btn btn-danger">Print</button>
        </div>
        <%
                }%>

    </body>
</html>
