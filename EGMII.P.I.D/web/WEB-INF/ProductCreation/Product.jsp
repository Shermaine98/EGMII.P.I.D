<%-- 
    Document   : Product
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="Model.RefColor"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="bootstrap/css/searchStyle.css">
        <!--AUTO COMPLETE LIBRARIES-->
        <script type="text/javascript" src="js/jquery.autocomplete.js"></script>

        <!--PERSONAL LIBRARIES-->
        <script type="text/javascript" src="js/searchItem.js"></script>
        <script type="text/javascript" src="js/deleteRow.js"></script>
        <script type="text/javascript" src="js/number.js"></script>
         <script src="js/Validation.js"></script>
        <title>Bill of Materials</title>
    </head>
    <body> 
        <br/>
        <form method="POST" action="EncodeProductServlet">
            <div align="center">
                <h2>Encode Bill of Materials</h2>
                <br/>
                <div align="center" class="container">
                    <div class="panel panel-default col-md-3">
                        <div class="panel-heading">
                            <h3 class="panel-title">Bill of Materials</h3>
                        </div>
                        <div class="panel-body">
                            <label class="" for="productName">Product Name</label>
                            <input type="text" name="productName" class="form-control" id="productName" pattern=".{1,}" required title="Please Input Product Name"/><br/>
                            <label class="" for="productType">Product Type</label>
                            <select name="productType" id="productType" class="form-control">
                                <option value="pants">Pants</option>
                                <option value="shirt">Shirt</option>
                            </select><br/>
                            <%ArrayList<RefColor> refColor = (ArrayList<RefColor>) request.getAttribute("ColorList");%>
                            <label class="" for="color">Color</label>
                            <select name="color" class="form-control">
                                <%for (int i = 0; i < refColor.size(); i++) {%>
                                <option value="<%=refColor.get(i).getColor()%>"><%=refColor.get(i).getColor()%></option>
                                <%}%>
                            </select><br/>
                            <label class="" for="inventoryType">Inventory Type</label>
                            <input type="text" name="inventoryType" class="form-control" value="Warehouse" readonly ="readonly" /><br/>
                        </div>
                    </div>

                    <div class="panel panel-default col-md-7">
                        <div class="panel-heading">
                            <h3 class="panel-title">Add Accessories Item</h3>
                        </div>
                        <div class="panel-body">
                            <div class="input-group">
                                <input type="text" class="form-control" name="itemNameSearch" id="itemNameSearch" onkeypress="autoComplete()" placeholder="Search Item"/>
                                <span class="input-group-btn"> <button type="button" onClick="getItem()" class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
                            </div>
                            <br/><br/>

                            <table id="thisTable" class="table table-bordered">
                                <colgroup>
                                    <col style="width:5%"/>
                                </colgroup>
                                <tbody id="dataTable">
                                </tbody>
                            </table>
                            <br/>
                            <div id="buttons" style="visibility: hidden">
                                <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable')" />
                                <br/><br/>
                            </div>
                        </div>
                    </div>

                    <!--CHOOSE FABRIC!!!!!!-->
                    <div class="panel panel-default col-md-7 pull-right" style="margin-right: 140px;">
                        <div class="panel-heading">
                            <h3 class="panel-title">Choose Fabric</h3>
                        </div>
                        <div class="panel-body">
                            <div class="input-group">
                                <input type="text" class="form-control" name="fabricNameSearch" id="fabricNameSearch" onkeypress="autoCompleteFabric()" placeholder="Search Fabric"/>
                                <span class="input-group-btn"><button type="button" onClick="getFabricItem()" class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
                            </div>
                            <br/><br/>

                            <div class="table-responsive">
                                <table id="thisTableFabric" class="table table-bordered">
                                    <tbody id="dataTableFabric">

                                    </tbody>
                                </table>
                            </div>
                            <br/>
                            <!--Should be a different js-->
                            <div id="buttonsFabric" style="visibility: hidden">
                                <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRowF('thisTableFabric')" />
                                <br/><br/>
                            </div>
                        </div>
                    </div>
                </div> 
            </div> 

            <div align="center">
                <input type="submit" class="btn btn-default" value="Create"><br/><br/>
                <button type="button" class="btn btn-primary">Delete</button>
                <a href="/EGMII.P.I.D/Account?action=goToHome"><button type="button" class="btn btn-primary" >Cancel</button></a>
            </div>
        </form>
                           
         </body>
         
</html>
