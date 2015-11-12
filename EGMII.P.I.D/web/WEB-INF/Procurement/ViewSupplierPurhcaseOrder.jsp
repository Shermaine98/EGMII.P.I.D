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
                $(".SPO").on("click", (function () {
                    var productionNumber = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = productionNumber;
                    document.getElementById("form1").submit();
                }));
              $(".trclass").each(function () {
                    var $this = $(this);
                    var unitPrice = parseFloat($this.find('[id="unitPrice\\[\\]"]').val());
                    var volumeQty = parseFloat($this.find('[id="volumeQty\\[\\]"]').val());
                    var STotal = unitPrice * volumeQty;
                    $this.find('[id="TQP\\[\\]"]').val(STotal);
                    SolveTotal();
                });
                return false;
            });

            function SolveTotal() {
                var STotal = 0;
                $(".trclass").each(function () {
                    var $this = $(this);
                    var TQP = parseFloat($this.find('[id="TQP\\[\\]"]').val());
                    STotal = STotal + TQP;
                    document.getElementById('total').value = STotal;
                });
                return false;
            }
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
        <div align="center" class="container" style="width:70%">
            <table id="dataTable" class="table table-bordered table-hover">
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
                        <td class="poNumber"><%= SupplierPurchaseOrderList.get(i).getPoNumber()%></td>
                        <td><%= SupplierPurchaseOrderList.get(i).getCompanyName()%></td>
                        <td><%= SupplierPurchaseOrderList.get(i).getDateMade()%></td>
                        <td><%= SupplierPurchaseOrderList.get(i).getDeliveryDate()%></td>
                        <td><%= SupplierPurchaseOrderList.get(i).getPreparedBy()%></td>
                        <td><%= SupplierPurchaseOrderList.get(i).getApprovedBy()%></td>        
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <input type="hidden" name="poNumber" id="hiddenValue" value=""/>
        </div>
    </form>


    <div id="printableArea">
        <%
            if (data.equalsIgnoreCase("SupplierPurchaseOrderSpecific")) {
                ArrayList<SupplierPurchaseOrderView> spo1 = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderSpecific");
                if (!spo1.isEmpty()) {
        %>
        <!--Consumption Report View From Encode of Bill of Materials-->

        <div class="container" align="center">
            <div class="panel panel-default col-md-3">
                <div class="panel-heading">
                    <h3 class="panel-title">Supplier Purchase Order</h3>
                </div>
                <div class="panel-body h5" align="left">
                    <label for="poNumber">Purchase Order No: </label>
                    <%=spo1.get(0).getPoNumber()%> <br/><br/>
                    <label for="preparedBy">Prepared By: </label>
                    <%=spo1.get(0).getPreparedBy()%><br/><br/>
                    <label for="dateMade">Date Made: </label>
                    <%=spo1.get(0).getDateMade()%> <br/><br/>
                    <label for="deliveryDate">Delivery Date: </label>
                    <%=spo1.get(0).getDeliveryDate()%><br/><br/>
                    <label for="supplier">Supplier: </label>
                    <%=spo1.get(0).getCompanyName()%><br/><br/>
                    <input type="text" class="hidden" readonly name="employeeNumber" value="<%=user.getEmployeeNumber()%>"/>
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
                            <td><input type="text" class="transparentBg inputSize readonlyWhite" readonly id="TQP[]"/></td>   
                        </tr>
                        <% } %>
                    </table>

                    <div id="run" class="form-inline pull-right">
                        <label for="total">Total:</label>
                        <input type="number" class="form-control readonlyWhite" name="total" id="total" readonly /> 
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <br/><br/>

        <%}%>
    </div>
    <center>
        <input type="button" class="btn btn-default" onclick="printDiv('printableArea')" value="Print" />
    </center>
</body>

</html>
