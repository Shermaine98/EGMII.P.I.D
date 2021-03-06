<%-- 
    Document   : Inventory Report
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model_View.RetailInventoryView"%>
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
        <script src="js/Validation.js"></script>
        <title>Inventory Report</title>

        <script>
            function SolveEndingInv() {
                var endingT = 0;
                $(".trclass").each(function () {
                    var $this = $(this);
                    var begQty = parseFloat($this.find('[id="bgQty\\[\\]"]').val());
                    var soldQty = parseFloat($this.find('[id="soldQty\\[\\]"]').val());
                    var pulledQty = parseFloat($this.find('[id="pulledQty\\[\\]"]').val());
                    endingT = begQty - (soldQty + pulledQty);
                    $this.find('[id="endingT\\[\\]"]').val(endingT);
                });
                return false;
            }
            $(document).ready(function () {
                $(".trclass").on("keyup", (function () {
                    var pulledQty = parseFloat($(this).closest("tr").find('[id="pulledQty\\[\\]"]').val());
                    var soldQty = parseFloat($(this).closest("tr").find('[id="soldQty\\[\\]"]').val());
                    var bgQty = parseFloat($(this).closest("tr").find('[id="bgQty\\[\\]"]').val());
                    if (pulledQty !== 0 || soldQty !==0) {
                        var remainingTotal = bgQty - (pulledQty + soldQty);
                        if ( Math.abs(remainingTotal) > bgQty || remainingTotal < 0) {
                            window.alert("Quantity exceeds possible beginning quantity");
                            $(this).closest("tr").find('[id="pulledQty\\[\\]"]').val(0);
                            $(this).closest("tr").find('[id="soldQty\\[\\]"]').val(0);
                            $(this).closest("tr").find('[id="endingT\\[\\]"]').val(0);
                        } 
                    }
                    SolveEndingInv();

                }));
            });
        </script>
    </head>
    <body>
        <form method="post" action="EncodeInventoryReportServlet">
            <div class="container" align="center">

                <h2>Inventory Report</h2>
                <% ArrayList<RetailInventoryView> retailInventoryView = (ArrayList<RetailInventoryView>) request.getAttribute("retailInventoryView");
                    if (retailInventoryView.size() > 0) {
                Integer reportID = (Integer) request.getAttribute("reportID");
                %>


                <div class="panel panel-default col-md-3" style="padding-bottom:10px;">
                    <div class="panel-heading">
                        <h3 class="panel-title">Inventory Report</h3>
                    </div>
                    <div class="panel-body">
                        <label for="outlet">Report ID</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="outlet" value="<%=reportID%>"/><br/>
                        <label for="outlet">Outlet</label>
                        <input type="text" class="form-control readonlyWhite" readonly name="outlet" value="<%=retailInventoryView.get(0).getBranchName()%>"/><br/>
                        <label for="promo">Promo</label>
                        <input type="hidden" class="form-control readonlyWhite" readonly name="promo" value="<%=user.getEmployeeNumber()%>"/>
                        <input type="text" class="form-control readonlyWhite" readonly name="promo" value="<%=user.getFirstName()%> <%=user.getLastName()%>"/><br/>
                    </div>
                </div>


                <div class="panel panel-default col-md-7" style="padding-bottom: 10px;">
                    <div class="panel-body">
                        <table class="table table-bordered">
                            <tr>
                                <th>Product Name</th>
                                <th>Color</th>
                                <th>Size</th>
                                <th>Beginning Inventory</th>
                                <th>Pulled Out</th>
                                <th>Sold Out</th>
                                <th>Ending Inventory</th>
                            </tr>
                            <%for (int i = 0; i < retailInventoryView.size(); i++) {%>
                            <tr class="trclass">
                                <td><%=retailInventoryView.get(i).getProductName()%>
                                    <input type="hidden" value="<%= retailInventoryView.get(i).getItemCode()%>" name="itemCode" /></td>
                                <td><%=retailInventoryView.get(i).getColor()%></td>
                                <td><%=retailInventoryView.get(i).getSize()%></td>
                                <td><input type="text" class="transparentBg inputSize"  readonly name="begQty" id="bgQty[]" value="<%=retailInventoryView.get(i).getQty()%>"</td>
                                <td><input type="number" onkeypress="return event.charCode >= 48 && event.charCode <= 57" class="form-control inputSize"  name="pulledQty" id="pulledQty[]"  value="0" min="0"></td>
                                <td><input type="number" onkeypress="return event.charCode >= 48 && event.charCode <= 57" class="form-control inputSize" name="soldQty" id="soldQty[]"  value="0" min="0"></td>
                                <td><input type="text" class="transparentBg inputSize" id="endingT[]" readonly value="0" /></td>
                            </tr>
                            <%}%>
                        </table>

                    </div>
                </div>

            </div>
            <!--Buttons-->
            <div id="buttonz" align="center">
                <input type="submit" value="Send" class="btn btn-danger"/>
                <button class="btn btn-danger">Cancel</button>
            </div>
        </form>
        <%} else { %>
        <h3>NO INVENTORY RECORD FOR THIS RETAIL STORE</h3>
        <%}%>
    </body>
</html>
