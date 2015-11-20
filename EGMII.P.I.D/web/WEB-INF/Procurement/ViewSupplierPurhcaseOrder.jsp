<%-- 
    Document   : View Supplier Purchase Order
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
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
        <script src="js/searchSupplier.js"></script>
        <script src="js/Validation.js"></script>
        <script src="js/Print.js"></script>
        <title>View Supplier Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
                    var productionNumber = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = productionNumber;
                    document.getElementById("form1").submit();
                }));

              
            });

            
        </script>
        <style>
            label{
                font-weight:Bold;
            }
        </style>
    </head>
    <body>  
        <br/>
    <center><h2>View Supplier Purchase Order</h2></center>

    <br/><br/>
    <%        String data = (String) request.getAttribute("data");
        ArrayList<SupplierPurchaseOrderView> SupplierPurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrder");
    %>
    <form id="form1" method="post" action="ViewSupplierPurchaseOrderServlet">
        <div align="center" class="container">
            <table id="dataTable" class="table table-bordered table-hover">
                <colgroup>
                    <col style="width: 12%" />
                    <col style="width: 40%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>Purchase Order Number</th>
                        <th>Supplier</th>
                        <th>Data Made</th>
                        <th>Delivery Date</th>
                        <th>Prepared By</th>
                        <th>Approved By</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < SupplierPurchaseOrderList.size(); i++) {
                    %> 
                    <tr class="SPO">
                        <td class="poNumber"><%= SupplierPurchaseOrderList.get(i).getPoNumber()%><input type="text" readonly  class="transparentBg"/></td>
                        <td><input type="text" class="transparentBg" readonly  style="width:100%" value="<%= SupplierPurchaseOrderList.get(i).getCompanyName()%>"/></td>
                        <td><input type="text" class="transparentBg" readonly  value="<%= SupplierPurchaseOrderList.get(i).getDateMade()%>"/></td>
                        <td><input type="text" class="transparentBg" readonly  value="<%= SupplierPurchaseOrderList.get(i).getDeliveryDate()%>"/></td>
                        <td><input type="hidden" class="transparentBg"  value="<%= SupplierPurchaseOrderList.get(i).getPreparedBy()%>"/><input type="text" class="transparentBg" readonly  value="<%= SupplierPurchaseOrderList.get(i).getPreparedByName()%>"/></td>
                        <td><input type="hidden" class="transparentBg"  value="<%= SupplierPurchaseOrderList.get(i).getApprovedBy()%>"/><input type="text" class="transparentBg" readonly  value="<%= SupplierPurchaseOrderList.get(i).getApprovedByName()%>"/></td>        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <input type="hidden" name="poNumber" id="hiddenValue" value=""/>
        </div>
    </form>



    <%
        if (data.equalsIgnoreCase("SupplierPurchaseOrderSpecific")) {
            ArrayList<SupplierPurchaseOrderView> spo1 = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderSpecific");
            if (!spo1.isEmpty()) {
                double total=0;
    %>
    <!--Consumption Report View From Encode of Bill of Materials-->
    <div id="printableArea">
        <div class="container" align="center">
            <div class="panel panel-default col-md-3">
                <div class="panel-heading">
                    <h3 class="panel-title">Supplier Purchase Order</h3>
                </div>
                <div class="panel-body h5" align="left">
                    <label for="poNumber">Purchase Order No: </label>
                    <%=spo1.get(0).getPoNumber()%> <br/><br/>
                    <label for="preparedBy">Prepared By: </label>
                    <%=spo1.get(0).getPreparedByName()%><br/><br/>
                    <label for="dateMade">Date Made: </label>
                    <%=spo1.get(0).getDateMade()%> <br/><br/>
                    <label for="deliveryDate">Delivery Date: </label>
                    <%=spo1.get(0).getDeliveryDate()%><br/><br/>
                    <label for="supplier">Supplier: </label>
                    <%=spo1.get(0).getCompanyName()%><br/><br/>
                    <label for="approveby">Approved By </label>
                    <%=spo1.get(0).getApprovedByName()%><br/><br/>

                </div>
            </div>
            <div class="panel panel-default col-md-7">
                <div class="panel-heading">
                    <h3 class="panel-title">Details</h3>
                </div>
                <div class="panel-body">
                    <table class="table table-bordered">
                        <colgroup>
                            <col style="width: 40%" />
                        </colgroup>
                        <tr>
                            <th>Item Name</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Total Price</th>
                        </tr>
                        <%for (int x = 0; x < spo1.size(); x++) {%>
                        <tr class="trclass">
                            <td><%=spo1.get(x).getItemName()%></td>
                            <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly value ="<%=spo1.get(x).getUnitPrice()%>" id="unitPrice[]"/></td>
                            <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly value="<%=spo1.get(x).getQty()%>" id="volumeQty[]"/></td>
                            <td><input type="text" class="transparentBg inputSize readonlyWhite" value="<%=spo1.get(x).getQty() * spo1.get(x).getUnitPrice()%>" readonly id="TQP[]"/>
                            <% 
                            
                                total = spo1.get(x).getQty() * spo1.get(x).getUnitPrice(); 
                            
                            %>
                        </tr>
                        <% } %>
                    </table>

                    <div id="run" class="form-inline pull-right">
                        <label for="total">Total:</label>
                        <input type="number" class="form-control readonlyWhite" name="total" value="<%=total%>" id="total" readonly /> 
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <br/><br/>
    </div>
    <div>
        <center>
            <input type="button" class="btn btn-default" onclick="printDiv('printableArea')" value="Print" />
        </center>
    </div>
    <%}%>


</body>

</html>
