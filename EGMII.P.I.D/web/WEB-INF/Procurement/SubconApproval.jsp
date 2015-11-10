<%-- 
    Document   : Approval
    Created on : 11 4, 15, 10:58:14 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.ConsumptionReportView"%>
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
        <script src="js/Validation.js"></script>
        <title>Subcontractor Purchase Order Approval</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true,
//                    "dom": '<"pull-left "f>'
                });

                $(".SubconPoView").on("click", (function () {
                    var purchaseOrde`rNum = $(this).closest("tr").find(".poNumber").text();
                            document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
            });</script>
    </head>
    <body>
        <%              ArrayList<SupplierPurchaseOrderView> PurchaseOrderList = (ArrayList<SupplierPurchaseOrderView>) request.getAttribute("PurchaseOrderList");
        %>
        <div class="container" align="center">
            <h2>Approve Subcontractor Purchase Order</h2><br/>

            <div style="width:60%;">
                <table id="dataTable" class="table table-bordered table-hover">
                    <colgroup>
                        <col style="width:23%" />
                        <col style="width:35%" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>Purchase Order No.</th>
                            <th>Subcontractor</th>
                            <th>Date Made</th>
                            <th>Delivery Date</th>
                            <th>Prepared By</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < PurchaseOrderList.size(); i++) {%>
                        <tr class="SubconPoView">
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
        </div>

        <% String data = (String) request.getAttribute("subconData");
            if (data.equalsIgnoreCase("consumption")) {
                Integer poNumber = (Integer) request.getAttribute("poNumber");
        %>
        <form method="POST" action="ApproveRejectSubconPOServlet">
            <div align="center" class="container">
                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" class="form-control" readonly name="poNumber" value ="" /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="text" class="form-control" readonly name="preparedBy" value ="" /><br/>
                        <label for="subconName">Subcontractor</label>
                        <input type="text" class="form-control" readonly name="subcontractor" value ="" /><br/>

                        <br/>  
                        <label class="" for="productionNumber">Production Number</label>
                        <input type="text" name="productionNumber" id="productionNumber" class="form-control readonlyWhite" readonly value=""  /><br/>
                        <label class="" for="productName">Product Name</label>
                        <input type="text" name="productName" class="form-control readonlyWhite" value="" readonly /><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" name="productType"  class="form-control readonlyWhite" readonly id="productType" value="" /><br/>
                        <label for="color">Color</label>
                        <input type="text" name="color" class="form-control readonlyWhite" value="" readonly /><br/>
                    </div>
                </div>
            </div>
            <div id="buttonz" align="center">
                <!--Buttons-->
                <input type="submit" value="Approve" class="btn btn-default" />
                <button class="btn btn-primary">Reject</button><br/><br/>
            </div>
        </form>
        <div align="center"> 
            <form>
                <button class="btn btn-default">Print</button>
            </form>
        </div>
        <% }%>
    </body>
</html>
