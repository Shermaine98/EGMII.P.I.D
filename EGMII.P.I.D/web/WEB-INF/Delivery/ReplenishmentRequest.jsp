<%-- 
    Document   : ReplenishmentRequest
    Created on : 11 4, 15, 10:06:53 PM
    Author     : Geraldine
--%>

<%@page import="Model.InventoryReportCom"%>
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
         <script type="text/javascript" src="js/jquery.autocomplete.js"></script>
        <script src="js/searchWarehouse.js"></script>
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
                  $('#invR').DataTable({
                    "paging": true,
                    "info": true
                });

                $(".repView").on("click", (function () {
                    var purchaseOrderNum = $(this).closest("tr").find(".reportID").text();
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
            <%        ArrayList<InventoryReportView> InventoryReport = (ArrayList<InventoryReportView>) request.getAttribute("inventoryReports");
                if (InventoryReport.size() > 0) {
            %>
            <form id="form1" method="POST" action="ViewReplenishmentServlet?action=specific">
                <div class="container" align="center">
                    <h2>Inventory Reports</h2><br/>
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
                                <tr class="repView">
                                    <td class="reportID"><%=InventoryReport.get(i).getReportID()%></td>
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
                    <input type="hidden" name="invId" id="hiddenValue" value=""/>
                </div>
            </form>

            <%
                String data = (String) request.getAttribute("data");
                if (data.equalsIgnoreCase("specific")) {
               ArrayList<InventoryReportCom> InventoryReportS = (ArrayList<InventoryReportCom>) request.getAttribute("InventoryReportCom");
               Integer repID = (Integer) request.getAttribute("repID");
            %>
            
            
            <!--Inventory Report Data Table-->
            
             <h2>Inventory Report Details</h2><br/>
            <div style="width:60%;">
                        <table id="invR" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Color</th>
                                    <th>Size</th>
                                    <th>Sold Out</th>
                                    <th>Pulled Out</th>
                                    <th>Current Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < InventoryReportS.size(); i++) {%>
                                <tr class="repView">
                                    <td class="reportID"><%=InventoryReportS.get(i).getProductName()%></td>
                                    <td><%=InventoryReportS.get(i).getColor()%></td>
                                    <td><%=InventoryReportS.get(i).getSize()%></td>
                                    <td><%=InventoryReportS.get(i).getSoldQty()%></td>
                                    <td><%=InventoryReportS.get(i).getPulledQty()%></td>
                                    <td><%=InventoryReportS.get(i).getCurrentQty()%></td>
                                </tr>
                                <%
                                        
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                            
            <div class="panel panel-default col-md-3">
               
                <div class="panel-body">
                    <label for="outlet">Outlet</label>
                    <input type="hidden" class="form-control" readonly name="location" value="<%=InventoryReportS.get(0).getLocationID()%>" /><br/>
                    <input type="text" class="form-control" readonly name="outlet" value="<%=InventoryReportS.get(0).getBranchName()%>" />
                    <label for="promo">Promoter</label>
                     <input type="hidden" class="form-control" readonly name="promo" value="<%=InventoryReportS.get(0).getPromoid()%>" />
                    <input type="text" class="form-control" readonly  value="<%=InventoryReportS.get(0).getName()%>" /><br/>
                    <label for="date">Date Inventory </label>
                    <input type="text" class="form-control" readonly name="date" value="<%=InventoryReportS.get(0).getDateMade()%>" /><br/>
                    <label for="repID">Replenishment ID</label>
                    <input type="text" class="form-control" readonly name="repID" value="<%=repID%>" /><br/>
                    <input type="hidden" class="form-control" readonly name="supervisor" value="<%=user.getEmployeeNumber()%>" /><br/>
                </div>
            </div>

            <div class="panel panel-default col-md-7">
                <br> 
                 <div class="input-group">
                    <input type="text" class="form-control" name="productName" id="productName" onkeypress="autoCompleteWarehouseInventory()" placeholder="Search Product"/>
                    <span class="input-group-btn">
                        <a href="#" onClick="getWarehouseInventory()" class="btn btn-default">
                            <span class="glyphicon glyphicon-search"></span>
                        </a>
                    </span>
                </div>
                 <br>
                <div class="panel-body">
                    <table id="ReplenishItem" class="table table-bordered">
                        
<!--                        <tr><td><input type="text" class="transparentBg" name="productName" /></td><td><select name="color" class="transparentBg"><option value="sample">Sample</option></select></td>
                            <td>
                                <select name="size" class="transparentBg">
                                    <option value="sample">Sample</option>
                                </select>  
                            </td>
                            <td>
                                <input type="number" class="transparentBg inputSize" name="quantity" />  
                            </td>
                        </tr>-->
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
        <%
            }
        %>
    </body>
</html>
