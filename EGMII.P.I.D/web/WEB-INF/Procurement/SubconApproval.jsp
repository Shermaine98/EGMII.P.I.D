<%-- 
    Document   : Approval
    Created on : 11 4, 15, 10:58:14 AM
    Author     : Geraldine
--%>

<%@page import="Model_View.SubconPurchaseOrderView"%>
<%@page import="Model_View.RawMaterialsInventoryView"%>
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
                    "info": true
                });

                $(".SubconPoView").on("click", (function () {
                    var poNumber = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = poNumber;
                    document.getElementById("form1").submit();
                }));
            });</script>
    </head>
    <body>
        <% ArrayList<SubconPurchaseOrderView> ConsumptionReportView = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("PurchaseOrderList");%>
        <form id="form1" method="post" action="SetApprovalSubconPOServlet">
            <div class="container" align="center">
                <h2>Search Consumption Report</h2><br/>
                <div style="width:60%;">
                    <table id="dataTable" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>Purchase Order Number</th>
                                <th>Production Number</th>
                                <th>Product Name</th>
                                <th>Product Type</th>
                                <th>Date Made</th>
                                <th>Prepared By</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < ConsumptionReportView.size(); i++) {%>
                            <tr class="SubconPO">  
                                <td><%=ConsumptionReportView.get(i).getPoNumber()%></td>
                                <td><%=ConsumptionReportView.get(i).getProductionNumber() %></td>
                                <td><%=ConsumptionReportView.get(i).getProductName()%></td>
                                <td><%=ConsumptionReportView.get(i).getProductType()%></td>
                                <td><%=ConsumptionReportView.get(i).getDateMade()%></td>
                                <td><%=ConsumptionReportView.get(i).getPreparedBy()%></td>
                                
                            </tr> 
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
        <br/>
        <%
            String data = (String) request.getAttribute("data");
            if (data.equalsIgnoreCase("subconApproval")) {
                // ArrayList<SubconPurchaseOrderView> PurchaseOrderSpecific = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("SubconReceivingSpecific");
        %>
        <form method="POST" action="ApproveRejectSubconPOServlet">
            <div align="center" class="container">

                <div class="panel panel-default col-md-3">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <%--
<!--                    
                    <div class="panel-body">
                        <label class="" for="poNumber">Purchase Order Number</label>
                        <input type="text" name="poNumber" class="form-control " id="poNumber" value="<%=PurchaseOrderSpecific.get(0).getPoNumber()%>" readonly /><br/>
                        <label class="" for="preparedBy">Prepared By</label>
                        <input type="hidden" name="preparedBy" class="form-control "   value="<%=PurchaseOrderSpecific.get(0).getPreparedBy()%>"/><br/>
                        <input type="text" class="form-control " readonly  value="<%=PurchaseOrderSpecific.get(0).getPreparedByName()%>"/><br/>
                        <label class="" for="deliveryDate">Delivery Date</label>
                        <input type="text" name="deliveryDate" class="form-control"  value="<%=PurchaseOrderSpecific.get(0).getDeliveryDate()%>"/><br/>
                        Search Subcon
                        <label for="subconName">Subcontractor</label>
                        <input type="text" class="form-control" name="subconName" id="subconName" value="<%=PurchaseOrderSpecific.get(0).getCompanyName()%>"/>
                        <br/>  

                        <label class="" for="productionNumber">Production Number</label>
                        <input type="text" name="productionNumber" id="productionNumber" class="form-control readonlyWhite" readonly value=<%=PurchaseOrderSpecific.get(0).getProductionNumber()%>  /><br/>
                        <label class="" for="productName">Product Name</label>
                        <input type="text" name="productName" class="form-control readonlyWhite" value="<%=PurchaseOrderSpecific.get(0).getProductName()%>" readonly /><br/>
                        <label for="productType">Product Type</label>
                        <input type="text" name="productType"  class="form-control readonlyWhite" readonly id="productType" value="<%=PurchaseOrderSpecific.get(0).getProductType()%>" /><br/>
    
                    </div>-->
                    --%>
                </div>
                <!--
                <%-- ArrayList<RawMaterialsInventoryView> rmwi = (ArrayList<RawMaterialsInventoryView>) request.getAttribute("rmwInventory"); %>
                not enough inventory
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Subcontractor Purchase Order</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable3" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Inventory Balance Quantity</th>
                                </tr>
                            </thead>
                            <tbody> 
                                <%for (int i = 0; i < rmwi.size(); i++) {
                                        if (rmwi.get(i).getQtyNeeded() < 0) {
                                %>
                                <tr style="background-color:#FF8080"> 
                                    <td><input onload="disabled()" type="text" value="<%=rmwi.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="hidden" id="trigger" value="true"/><input type="text" value="<%=rmwi.get(i).getQtyNeeded()%>" class="transparentBg" readonly/> 
                                </tr> 
                                <%
                                } else {
                                %>   
                                <tr> 
                                    <td><input type="text" value="<%=rmwi.get(i).getItemName()%>" class="transparentBg" readonly/> 
                                    <td><input type="text" value="<%=rmwi.get(i).getQtyNeeded()%>" class="transparentBg" readonly/> 
                                </tr> 
                                <%
                                        }
                                    }%>
                            </tbody>
                        </table>
                    </div>
                </div>


                view here


                <%
                    if (PurchaseOrderSpecific.get(0).getProductType().equalsIgnoreCase("Shirt")) {
                %>
                <div class="panel panel-default col-md-7" style="float:left">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-bordered table-responsive">
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="XS" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="S" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="M" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="L" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite" value="XL" readonly/></th>
                                <th>Total</th></tr>
                            <tr>
                                <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeXS" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeM" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeXL" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalShirt();" value="0" /></td>
                                <td><input name="TotalS" class="transparentBg" id="TotalS" value="0" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <%
                } else {
                %>
                ELSE HERE
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Sizes</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table class="table table-bordered">
                            1  
                            <tr>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="28" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="29" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="30" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="31" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="32" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="33" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="34" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="36" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="38" readonly/></th>
                                <th><input name="sizeType" class="transparentBg readonlyWhite input" value="40" readonly/></th>
                                <th>Total</th>
                            </tr>
                            2  
                            <tr><td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size29" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size28" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size30" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size31" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size32" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size33" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size34" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size36" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size38" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input type="number" readonly class="transparentBg readonlyWhite input" name="volumeQty" id="size40" onkeypress="return event.charCode >= 48 && event.charCode <= 57" onChange="calculateTotalPants();" value="0" /></td>
                                <td><input name="TotalP" class="transparentBg readonlyWhite input" id="TotalP" value="0" readonly/></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <%}%>

                ACCESSORIES
                <div class="panel panel-default col-md-7">
                    <div class="panel-heading">
                        <h3 class="panel-title">Accessories</h3>
                    </div>
                    <div class="panel-body table-responsive">
                        <table id="dataTable3" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Consumption</th>
                                    <th>Total Consumption</th>
                                    <th>Unit Measurement</th>
                                </tr>
                            </thead>
                            <tbody >
                <%--
                    ArrayList<ConsumptionReportView> productAllAcce = (ArrayList<ConsumptionReportView>) request.getAttribute("crListSpecific");
                    for (int i = 0; i < productAllAcce.size(); i++) {
                        if (productAllAcce.get(i).getInventoryType().equalsIgnoreCase("accessories")) {
                %>
                FOR LOOP
                <tr>
                    <td><input type="text" class="transparentBg readonlyWhite " name="itemName"  value = "<%= productAllAcce.get(i).getItemName()%>"  readonly/>
                        <input type="hidden" class="transparentBg readonlyWhite inputSize" name="itemCode"  value = "<%= productAllAcce.get(i).getItemCode()%>" /></td>
                    <td><input name="itemConsumption" class="transparentBg readonlyWhite inputSize" id="itemConsumption[]" value="<%= productAllAcce.get(i).getVolumeQty()%>"   readonly/></td> 
                    <td><input name="totalConsumption" class="transparentBg readonlyWhite inputSize" id="totalConsumption[]" value="<%=productAllAcce.get(i).getConsumptionQty()%>"  readonly/></td>
                    <td><input name="unitMeasurement" class="transparentBg readonlyWhite inputSize" id="unitMeasurement" value="<%= productAllAcce.get(i).getUnitMeasurement()%>"  readonly /></td>
                </tr> 
                <%
                        }
                    }
                --%>
                  close bracket here
              </tbody>
          </table>
      </div>
  </div>

   fabric 
  <div class="panel panel-default col-md-7 pull-right" style="margin-right:140px">
      <div class="panel-heading">
          <h3 class="panel-title">Choose Fabric</h3>
      </div>
      <div class="panel-body table-responsive">
          <table id="dataTable4" class="table table-bordered">
              <thead>
                  <tr> 
                      <th>Fabric Name</th>     
                      <th>Size</th> 
                      <th>Volume Qty Per Size</th>
                      <th>Consumption</th>
                      <th>Unit Measurement</th>
                  </tr>
              </thead>
              <tbody>
                <%--
                    ArrayList<ConsumptionReportView> productAllproduc = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforFabric");
                    for (int i = 0; i < productAllproduc.size(); i++) {
                        if (productAllproduc.get(i).getInventoryType().equalsIgnoreCase("production")) {
                
                <tr> 
                    <td><input type="text" value="<%=productAllproduc.get(i).getItemName()%>" class="transparentBg" readonly/> 
                    <td><input type="text" value="<%=productAllproduc.get(i).getSize()%>" class="transparentBg inputSize" readonly/> 
                    <td><input type="text" id="fabricItemConsumption[]" value="<%=productAllproduc.get(i).getVolumeQty()%>" class="transparentBg inputSize" readonly/> 
                    <td><input type="text" class="transparentBg readonlyWhite inputSize" id="totalConsumptionFabric[]" value="<%=productAllproduc.get(i).getConsumptionQty()%>"  readonly/></td>
                    <td><input type="text" value="<%=productAllproduc.get(i).getUnitMeasurement()%>" class="transparentBg" readonly/> 
                </tr> 
                <%
                        }
                    }
                %>
                --%>  
           </tbody>
       </table>
   </div>
   <br/>
</div>-->
            </div>
        </form>

        <div id="buttonz" align="center">
            <!--Buttons-->
            <input type="submit" value="Approve" class="btn btn-default" />
            <button class="btn btn-primary">Reject</button><br/><br/>
        </div>
        <div align="center"> 
            <form>
                <button class="btn btn-default">Print</button>
            </form>
        </div>
        <% }%>
    </body>
</html>
