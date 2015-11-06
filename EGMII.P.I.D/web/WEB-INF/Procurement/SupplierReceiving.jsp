<%-- 
    Document   : SupplierReceiving
    Created on : 11 4, 15, 1:43:12 PM
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
        <title>Receiving</title>
    </head>
    <script>
         $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true,
//                    "dom": '<"pull-left "f>'
                });

                $(".SupplierPOReceiving").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
            });
  //          $('#run').ready(function(){
    //         document.getElementById("run").addEventListener("load", SolveTQP);
      //          });
    </script>
    <% ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("Receiving");%>
    <body>
        <form method="post" action="SetSupplierSpecificReceivingServlet" id="form1">
        <div class="container" align="center">
            <h2>Supplier Purchase Order Receiving</h2><br/>
            <table id ="dataTable" class="table table-bordered" style="width:60%;">
                <thead>
                <tr>
                    <th>Purchase Order No.</th>
                    <th>Supplier</th>
                    <th>Delivery Date</th>
                    <th>Prepared By</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
               <%for(int i=0; i < PurchaseOrderList.size();i++){ %>
                <tr class="SupplierPOReceiving">
                    <td class="poNumber"><%=PurchaseOrderList.get(i).getPoNumber()%></td>
                    <td><%=PurchaseOrderList.get(i).getCompanyName()%></td>
                    <td><%=PurchaseOrderList.get(i).getDeliveryDate()%></td>
                    <td><%=PurchaseOrderList.get(i).getPreparedByName()%></td>
                    <td><%=PurchaseOrderList.get(i).isIsCompleted()%></td>
                </tr>
                <%} %>
                </tbody>
            </table>
             <input type="hidden" name="hiddenValueReceiving" id="hiddenValue" value=""/>
        </div>
                </form>
      <%
            String data = (String) request.getAttribute("receivingData");
            if (data.equalsIgnoreCase("receiving")) {
               ArrayList<SupplierPurchaseOrderView> PurchaseOrderSpecific = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("SupplierPurchaseOrderReceiving"); 
        %>
        <form method="post" action="EncodeSupplierDRServlet">
        <div class="container" align="center">
            <div class="panel panel-default col-md-4 pull-left" style="padding-bottom:10px; margin-left: 60px;">
                <div class="panel-body">
                    <label for="poNumber">Purchase Order No.</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="poNumber" value="<%=PurchaseOrderSpecific.get(0).getPoNumber()%>" /><br/>
                    <label for="preparedBy">Prepared By</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="preparedBy" value="<%=PurchaseOrderSpecific.get(0).getPreparedBy()%>" /><br/>
                    <label for="preparedBy">Received By</label>
                    <input type="hidden" class="form-control readonlyWhite" readonly name="receivedBy" value="<%=user.getEmployeeNumber()%>" /><br/>
                    <input type="text" class="form-control readonlyWhite" readonly  value="<%=user.getFirstName()%> <%=user.getLastName()%>" /><br/>
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="date" class="form-control"  name="deliveryDate" value="<%=PurchaseOrderSpecific.get(0).getDeliveryDate()%>"/><br/>
                    <label for="supplier">Supplier</label>
                    <input type="text" class="form-control readonlyWhite" readonly name="supplier" value="<%=PurchaseOrderSpecific.get(0).getCompanyName()%>" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-6 pull-left" style="padding-bottom:10px;">
                <div class="panel-body">

                    <div class="form-inline">
                        <label for="drNumber">Delivery Receipt Number</label>
                        <input type="text" class="form-control" name="drNumber" />
                    </div>
                    <br/>

                    <table class="table table-bordered" >
                        <colgroup>
                            <col style="width:60%" />
                        </colgroup>
                        <tr>
                            <th>Item Name</th>
                            <th>Quantity</th>
                            <th>Received</th>
                        </tr>
                         <%for(int x = 0; x < PurchaseOrderSpecific.size(); x++)
                        { %>
                        <tr class="trclass">
                            <td><%=PurchaseOrderSpecific.get(x).getItemName()%><input type="hidden" name="itemCode" value="<%=PurchaseOrderSpecific.get(x).getItemCode()%>" /></td>
                            <td><input type="text" value="<%=PurchaseOrderSpecific.get(x).getQty()%>" id="volumeQty[]"/></td>  
                            <td><input type="number" name="receivedqty" class="transparentBg inputSize" /></td>
                        </tr>
                        <% } %>
                    </table>

                    <br/>

                </div>
            </div>
        </div>

        <!--Buttons-->
        <div id="buttonz" align="center">
            <input type="submit" class="btn btn-danger"/>
        </div>
        <%}%>
        </form>
        <button class="btn btn-danger">Receive All</button>
    </body>
</html>