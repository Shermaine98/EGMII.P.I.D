<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model.SupplierPurchaseOrder"%>
<%@page import="Model.SubconPurchaseOrder"%>
<%@page import="Model.SubconPurchaseOrder"%>
<%@page import="Model.PurchaseOrder"%>
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
        <title>Receiving</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": false,
                    "info": false,
                    "dom": '<"pull-left "f>'
                });

                $(".viewpurchaseOrder").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".purchaseOrderNum").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    var l = document.getElementById('hiddenValue').value;
                    console.log(l);

                    document.getElementById("form1").submit();

                }));
            });
        </script>
    </head>
    <body>  
    <center><h2>Receiving</h2></center>

    <br/><br/>
    <%        ArrayList<PurchaseOrder> PurchaseOrderList = (ArrayList<PurchaseOrder>) request.getAttribute("PurchaseOrderList");
    %>
    <form id="form1" method="POST" action="GetPurchaseOrderSpecificServlet">
        <div align="center" class="container">
            <div style="float:left;">
                <table id="dataTable" class="table table-bordered table-hover table-responsive dataTable">
                    <thead>
                        <tr>
                            <th>Purchase Order Number</th>
                            <th>Date Made</th>
                            <th>Delivery Date</th>
                            <th>Prepared By</th>
                            <th>Receiving Status</th>
                            <th>Reconcile Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (int i = 0; i < PurchaseOrderList.size(); i++) {
                        %> 

                        <tr class="viewpurchaseOrder">
                            <td class="purchaseOrderNum"><%=PurchaseOrderList.get(i).getPoNumber()%></td>
                            <td><%= PurchaseOrderList.get(i).getDateMade()%></td>
                            <td><%= PurchaseOrderList.get(i).getDeliveryDate()%></td>
                            <td><%= PurchaseOrderList.get(i).getPreparedBy()%></td>
                            <td><%= PurchaseOrderList.get(i).getReceivingStatus()%></td>
                            <td><%= PurchaseOrderList.get(i).getReconcileStatus()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </div>

    </form>
    <!--Supplier Delivery Receipt--> 
    <%
        String data = (String) request.getAttribute("data");
        if (data.equalsIgnoreCase("supplier")) {
            //fix drNumber

            Integer x = (Integer) request.getAttribute("drNumber");
            ArrayList<SupplierPurchaseOrder> SupplierPurchaseOrder = (ArrayList<SupplierPurchaseOrder>) request.getAttribute("SupplierPurchaseOrderReceiving");
    %>
    <center><h2>Encode Supplier Purchase Order</h2></center>

    <form method="POST" action="EncodeSupplierDeliveryReceiptServlet">
        <div align="center" class="container width35">

            <div class="panel panel-default col-md-4">
                <div class="panel-heading">
                    <h3 class="panel-title">Supplier Purchase Order</h3>
                </div>
                <div class="panel-body">
                    <label class="" for="deliveryNumber">Delivery Number</label>
                    <input type="text" name="drNumber" class="form-control readonlyWhite" value="<%=x%>" readonly /><br/>
                    <label class="" for="poNumber">Purchase Order Number</label>
                    <input type="text" name="poNumber" class="form-control readonlyWhite" value="<%=SupplierPurchaseOrder.get(0).getPoNumber()%>" readonly /><br/>
                    <label class="" for="preparedBy">Prepared By</label>
                    <input type="text" class="form-control readonlyWhite" readonly value="<%=SupplierPurchaseOrder.get(0).getPreparedFirstName()%> <%=SupplierPurchaseOrder.get(0).getPreaparedLastName()%>" /><br/>
                    <label class="" for="dateCreated">Date Created</label>
                    <input type="text" class="form-control readonlyWhite" readonly value="<%=SupplierPurchaseOrder.get(0).getDateMade()%>" /><br/>
                    <label class="" for="receivedBy">Received By</label>
                    <input type="hidden" name="receivedBy"  value="<%=user.getEmployeeNumber()%>" /><br/>
                    <input type="text" class="form-control readonlyWhite" readonly value="<%=user.getFirstName()%> <%=user.getLastName()%>" /><br/>
                    <label class="" for="deliveryDate">Delivery</label>
                    <input type="text" name="deliveryDate" class="form-control readonlyWhite" value="<%=SupplierPurchaseOrder.get(0).getDeliveryDate()%>" readonly /><br/>
                    <label class="" for="supplier">Supplier</label>
                    <input type="text" name="supplier" class="form-control" value="<%=SupplierPurchaseOrder.get(0).getCompanyName()%>"/><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7">
                <div class="panel-heading">
                    <h3 class="panel-title">Supplier Purchase Details</h3>
                </div>
                <div class="panel-body">
                    <br/><br/>
                    <table id="data" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Item Name</th>
                                <th>Current Status</th>
                                <th>Volume Ordered</th>
                                <th>Unit Price</th>
                                <th>Unit Measurement</th>
                                <th>Inventory Type</th>
                                <th>Note</th>
                                <th>Received Quantity</th>
                                <th>Rejected Quantity</th>
                                <th>Add notes</th>
                            <tr>
                        </thead>
                        <%
                            for (int i = 0; i < SupplierPurchaseOrder.size(); i++) {
                        %>  
                        <tr>
                            <td><input type="hidden" name="itemCode" value="<%=SupplierPurchaseOrder.get(i).getItemCode()%>"><%= SupplierPurchaseOrder.get(i).getItemName()%></td>
                            <td><input type="hidden" name="status" value="<%= SupplierPurchaseOrder.get(i).getReceivingStatus()%>"/>
                                <%= SupplierPurchaseOrder.get(i).getReceivingStatus()%>
                            </td>
                            <td><input type="hidden" name="qty" value="<%= SupplierPurchaseOrder.get(i).getVolumeQty()%>"/><%= SupplierPurchaseOrder.get(i).getVolumeQty()%></td>
                            <td><%= SupplierPurchaseOrder.get(i).getUnitPrice()%></td>
                            <td><%= SupplierPurchaseOrder.get(i).getUnitMeasurement()%></td>
                            <td><%= SupplierPurchaseOrder.get(i).getInventoryType()%></td>
                            <td><%= SupplierPurchaseOrder.get(i).getNote()%></td>
                            <%
                                double maximum = 0;
                                System.out.print("received" + SupplierPurchaseOrder.get(i).getReceivedQty());
                                if (SupplierPurchaseOrder.get(i).getReceivedQty() == 0) {
                                    System.out.print("max 1" + SupplierPurchaseOrder.get(i).getReceivedQty());

                                    maximum = SupplierPurchaseOrder.get(i).getVolumeQty();
                                    System.out.print("volumeQty" + maximum);
                                } else {
                                    maximum = SupplierPurchaseOrder.get(i).getVolumeQty() - SupplierPurchaseOrder.get(i).getReceivedQty();
                                    System.out.print("volume qty" + SupplierPurchaseOrder.get(i).getVolumeQty());
                                    System.out.print("volume received" + SupplierPurchaseOrder.get(i).getReceivedQty());
                                    System.out.print("volume" + maximum);
                                }
                            %> 
                            <td><input type="number" name="receivedQty"  min="0" max="5.2"></td>
                            <td><input type="number" name="rejectQty"/></td>
                            <td><input name="notes"></td>
                        </tr>
                        <%
                            }
                        %>
                    </table> 
                    <div style="float:right">
                        TOTAL:
                        <input type="text" class="form-control readonlyWhite" name="Total1" id="total1" readonly />
                    </div>
                </div>
            </div>
            <input type="submit" style="width:77px; height:34px" class="btn btn-danger" value="Submit"> 
        </div>
    </form>
    <!--Supplier Delivery Receipt END-->    

    <%
    } else if (data.equalsIgnoreCase(
            "subcon")) {
        ArrayList<SubconPurchaseOrder> SubconPurchaseOrder = (ArrayList<SubconPurchaseOrder>) request.getAttribute("subconPurchaseOrderReceiving");
    %>
    <!--Subcon Delivery Receipt-->  
    <br/>

    <center><h2>Encode Supplier Purchase Order</h2></center>
    <form method="POST" action="EncodeSubcontractorPurchaseOrderServlet">
        <div align="center" class="container">
            <table class="table table-bordered width35">
                <thead>
                    <tr>
                        <th>Purchase Order number</th>
                        <td class="value"><input type="text" class="input" name="poNumber" /></td>
                    </tr>
                    <tr>
                        <th>Production Number</th>
                        <td><input type="text" class="input" name="itemCode" /></td>
                    </tr>
                    <tr>
                        <th>Prepared By</th>
                        <td><input type="text" class="input" name="preparedBy" /></td>
                    </tr>

                    <tr>
                        <th>Delivery Date</th>
                        <td><input type="text" class="input" name="deliveryDate" /></td>
                    </tr>
                    <tr>
                        <th>Vendor Type</th>
                        <td> <select name="vendorType">
                                <option value="Complete">All the Vendor Types</option>
                                <option value=""></option>
                                <option value=""></option>
                            </select></td>
                    </tr>
                </thead>
            </table>
            <table class="table table-bordered width35">
                <colgroup>
                    <col style="width:40%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>Subcontractor</th>
                        <td><input type="text" class="input" name="deliveryDate" value="fast search but filtred by vendor type"/></td>
                    </tr>
                </thead>
            </table>
            <table class="table table-bordered width35">
                <colgroup>
                    <col style="width:40%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <td><input type="text" class="input" name="productName"/></td>
                    </tr>
                </thead>
            </table>
            <center> <h2>Encode Supplier Purchase Order</h2> </center>
            <table class="table table-bordered width35">
                <thead>
                    <tr>
                        <th>S</th>
                        <th>M</th>
                        <th>L</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody id="dataTable">
                    <tr>
                        <td><input type="text" class="input" name="S" size="12" /></td>
                        <td class="value"><input type="text" class="input" name="M" size="12"/></td>
                        <td><input type="text" class="input" name="L" size="12"/></td>
                        <td><input type="text" class="input" name="qty" size="12"/></td>
                        <td><input type="text" class="input" name="total" size="12"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <th>TOTAL:</th>
                        <td><input type="text" class="input" name="Total" size="12" value ="TOTAL"/></td>
                    </tr>
                </tbody>

            </table>

            <br/><br/>
            <input type="button" class="btn btn-danger" value="Add Row" onclick="addRow('dataTable')" />
            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable')" />
            <input type="submit" style="width:77px; height:34px" class="btn btn-danger" value="Submit">
            <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
        </div>
    </form>
    <%
        }
    %>
    <script></script>
</body>

</html>
