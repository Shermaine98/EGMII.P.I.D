<%-- 
    Document   : Bill of Materials
    Created on : 08 20, 15, 6:43:37 PM
    Author     : Geraldine
--%>

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
        <title>Bill of Materials</title>
        <script>
            $(document).ready(function () {
                var prID = '${BoMPrNumber}';
                document.getElementById('productID').value = prID;
            });
        </script>
    </head>
    <body> 
        <br/>
        <div>
            <center><h2>Encode Bill of Materials</h2></center>
            <br/>
            <div align="center" class="container-fluid" style="margin-left:50px">
                <div class="panel panel-default col-md-4">
                    <div class="panel-heading">
                        <h3 class="panel-title">Bill of Materials</h3>
                    </div>
                    <div class="panel-body">
                        <label class="" for="productID">Product ID</label>
                        <input type="text" name="productID" class="form-control readonlyWhite" id="productID" readonly /><br/>
                        <label class="" for="sizeName">Size Name</label>
                        <select name="sizeName" class="form-control" id="sizeName">
                            <option value="Pants">Pants</option>
                            <option value="Shirt">Shirt</option>
                        </select>
                    </div>
                </div>
                <div class="panel panel-default col-lg-6 col-md-6 col-sm-6">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Item</h3>
                    </div>
                    <div class="panel-body">
                        <div class="input-group">
                            <input type="text" class="form-control" name="itemNameSearch" id="itemNameSearch" onkeypress="autoComplete()" placeholder="Search Item"/>
                            <input type="hidden" name="itemNameSearch" id ="itemNameSearch" disabled="disabled" style="color: #CCC; position: absolute; background: transparent;"/>
                            <span class="input-group-btn"><button onClick="getItem()" class="btn btn-default" ><span class="glyphicon glyphicon-search"></span></button></span>
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
                            <input type="button" class="btn btn-danger" onclick= "viewModal()" data-toggle="modal" data-target="#myModal" value="Create">
                            <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Cancel</button></a>
                        </div>
                    </div>
                </div>
            </div> 
        </div> 
        <div  align="center" class="container">
            <form method="POST" action="EncodeBillOfMaterialsServlet">
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title" id="myModalLabel">Are you sure?</h4>
                            </div>
                            <div class="modal-body">
                                <div align="center" style="width:60%">
                                    <label class="" for="productIDModal">Product ID</label>
                                    <input type="text" name="productIDModal" class="form-control readonlyWhite" id="productIDModal" readonly /><br/>
                                    <label class="" for="sizeTypeModal">Size Name</label>
                                    <input type="text" class="form-control readonlyWhite" name="sizeTypeModal" id="sizeTypeModal" readonly />
                                </div>
                                <br/><br/>

                                <table  id="thisTableModal" class="table table-bordered">
                                    <tbody id="dataTableModal">
                                    </tbody>
                                </table>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Edit</button>
                                    <input type="submit" class="btn btn-danger" value="Create">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
