<%-- 
    Document   : ReplenishmentRequest
    Created on : 11 4, 15, 10:06:53 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.InventoryReportView"%>
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
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bootstrap/css/jquery.dataTables.min.css">
        <link href="bootstrap/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"/>
         <script src="js/Validation.js"></script>
        <title>Replenishment Request</title>
        <style>
        </style>
        <script>
             $(document).ready(function () {
                $('#Replenish').DataTable({
                    "paging": true,
                    "info": true
                });

                $(".SupplierPOView").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = purchaseOrderNum;
                    document.getElementById("form1").submit();
                }));
            });
        </script>
    </head>
    <body>
        
        
        <div class="container" align="center">
            <h2>Replenishment Request</h2>
            <!--Click Inventory Reports-->
    <%        
      ArrayList<InventoryReportView> InventoryReport = (ArrayList<InventoryReportView>) request.getAttribute("inventoryReports");
      if(InventoryReport.size()<=0){
    %>
            <form id="form1" method="POST" action="">
            <div class="container" align="center">
                <h2>Approve Supplier Purchase Order</h2><br/>
                <div style="width:60%;">
                    <table id="Replenish" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Report ID</th>
                                <th>Branch Name</th>
                                <th>Promoter</th>
                                <th>Date Made</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (int i = 0; i < InventoryReport.size(); i++) {%>
                            <tr class="SupplierPOView">
                                <td class="poNumber"><%=InventoryReport.get(i).getReportID()%></td>
                                <td><%=InventoryReport.get(i).getBranchName()%></td>
                                <td><%=InventoryReport.get(i).getPromo()%></td>
                                 <td><%=InventoryReport.get(i).getDateMade()%></td>
                            </tr>
                            <%
                                }
      }
                            %>
                        </tbody>
                    </table>
                </div>
                <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
            </div>
        </form>
            
     
            

            <div class="panel panel-default col-md-3">
                <div class="panel-body">
                    <label for="outlet">Outlet</label>
                    <input type="text" class="form-control" readonly name="outlet" value="" /><br/>
                    <label for="promo">Promo</label>
                    <input type="text" class="form-control" readonly name="promo" value="" /><br/>
                    <label for="date">Date</label>
                    <input type="text" class="form-control" readonly name="date" value="" /><br/>
                    <label for="repID">Replenishment ID</label>
                    <input type="text" class="form-control" readonly name="repID" value="" /><br/>
                    <label for="version">Version</label>
                    <input type="text" class="form-control" readonly name="version" value="" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <th>Product Name</th>
                            <th>Color</th>
                            <th>Size</th>
                            <th>Quantity</th>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" class="transparentBg" name="productName" />  
                            </td>
                            <td>
                                <select name="color" class="transparentBg">
                                    <option value="sample">Sample</option>
                                </select>  
                            </td>
                            <td>
                                <select name="size" class="transparentBg">
                                    <option value="sample">Sample</option>
                                </select>  
                            </td>
                            <td>
                                <input type="number" class="transparentBg inputSize" name="quantity" />  
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <!--Buttons-->
        <div id="buttonz" align="center">
            <button class="btn btn-default">Save</button>
            <button class="btn btn-primary">Cancel</button><br/><br/>
            <button class="btn btn-default" style="width:140px">Print Picking Form</button>
        </div>
    </body>
</html>
