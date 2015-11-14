<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

<%@page import="Model_View.ConsumptionReportView"%>
<%@page import="Model_View.SubconPurchaseOrderView"%>
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
        <script src="js/Validation.js"></script>
        <title>View Subcontractor Purchase Order</title>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "paging": true,
                    "info": true
                });

                $("#dataTable tbody").on("click", 'input[type="text"]', (function () {
                    var poNumber = $(this).closest("tr").find(".poNumber").text();
                    document.getElementById('hiddenValue').value = poNumber;
                    document.getElementById("form1").submit();
                }));

                $("#datepicker").datepicker({minDate: 1, maxDate: "+4M +10D", dateFormat: 'yy-mm-dd'});

                var x = document.getElementById('trigger').value;
                if (x === "true") {
                    $('input[type="submit').prop('disabled', true);
                }
            });
        </script>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>View Subcontractor Purchase Order</h2></center>

    <br/><br/>

    <%            ArrayList<SubconPurchaseOrderView> ConsumptionReportView = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("SubconPOApproved");
    %>
    <form id="form1" method="post" action="ViewSubconPurchaseOrderServlet">
        <div class="container" align="center">
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
                            <td class="poNumber"><%=ConsumptionReportView.get(i).getPoNumber()%><input type="text" class="transparentBg inputSize"/></td>
                            <td><input type="text" name="productionNumber" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductionNumber()%>"/></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductName()%>"/></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getProductType()%>"/></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getDateMade()%>"/></td>
                            <td><input type="text" class="transparentBg inputSize" value="<%=ConsumptionReportView.get(i).getPreparedBy()%>"/></td>

                        </tr> 
                        <%}%>
                    </tbody>
                </table>
            </div>
            <input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
        </div>

        <%
            ArrayList<ConsumptionReportView> productSizes = (ArrayList<ConsumptionReportView>) request.getAttribute("CRforSizesA");
            ArrayList<SubconPurchaseOrderView> crHeader = (ArrayList<SubconPurchaseOrderView>) request.getAttribute("CRHeaderA");

        %>
        <!--Start Header-->
        <div class="panel panel-default col-md-3">
            <div class="panel-heading">
                <h3 class="panel-title">Supplier Purchase Order</h3>
            </div>
            <div class="panel-body">
                <label for="poNumber">Purchase Order No.</label>
                <input type="text" class="form-control" readonly name="poNumber" value ="<%=crHeader.get(0).getPoNumber()%>" /><br/>
                <label for="preparedBy">Prepared By</label>
                <input type="text" class="form-control" readonly name="preparedBy" value="<%=crHeader.get(0).getPreparedBy()%>"/><br/>
                <label for="deliveryDate">Delivery Date</label>
                <input type="text" class="form-control " readonly name="deliveryDate" value="<%=crHeader.get(0).getDeliveryDate()%>"/><br/>
                <label for="supplier">Subcontractor</label>
                <input type="text" class="form-control " readonly name="subcon" value="<%=crHeader.get(0).getSubconID()%>"/><br/>
                <label for="productionNumber">Production Number</label>
                <input type="text" class="form-control " readonly name="productionNumber" value="<%=crHeader.get(0).getProductionNumber()%>"/><br/>
                <label for="productName">Product Name</label>
                <input type="text" class="form-control " readonly name="productName" value="<%=crHeader.get(0).getProductName()%>"/><br/>
                <label for="productType">Product Type</label>
                <input type="text" class="form-control " readonly name="productType" value="<%=crHeader.get(0).getProductType()%>"/><br/>
                <label for="color">Color</label>
                <input type="text" class="form-control " readonly name="color" value="<%=crHeader.get(0).getProductColor()%>"/><br/>

                <input type="text" class="hidden" readonly name="employeeNumber" value="<%=user.getEmployeeNumber()%>"/>
            </div>
        </div>
        <!--End Header-->


        <!--Start Sizes-->
        <div class="panel panel-default col-md-7" style="float:left">
            <div class="panel-heading">
                <h3 class="panel-title">Sizes</h3>
            </div>
            <div class="panel-body">
                <table class="table table-bordered table-responsive">
                    <tr>
                        <%                                for (int i = 0; i < productSizes.size(); i++) {
                        %>
                        <th><input name="sizeType" class="transparentBg readonlyWhite" value="<%=productSizes.get(i).getSize()%>" readonly/></th>
                            <%
                                }
                            %>
                        <th>Total</th></tr>
                    <tr>
                        <%
                            double total = 0;
                            for (int i = 0; i < productSizes.size(); i++) {

                        %>
                        <td><input type="number" readonly class="transparentBg" name="volumeQty" id="sizeS" value="<%=productSizes.get(i).getVolumeQty()%>" /></td>
                            <%
                                    total += productSizes.get(i).getVolumeQty();
                                }
                            %>  
                        <td><input name="TotalS" class="transparentBg" id="TotalS" value="<%=total%>" readonly/></td>
                    </tr>
                </table>
            </div>
        </div>
        <!--End Sizes-->
    </form>
</body>

</html>
