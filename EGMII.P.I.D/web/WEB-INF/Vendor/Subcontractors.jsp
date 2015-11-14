<%-- 
    Document   : Subcontractor and Service
    Created on : Nov 14, 2015, 6:57:10 PM
    Author     : Atayan, Dimaandal, Lapidario, Nunez, Sy
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/LevelOfAccess/LevelOFAccess.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
          <link rel="stylesheet" type="text/css" href="bootstrap/tableBoarder.css">
          
        <title>Subcontractor</title>
    </head>
    <body>  
        <br/><br/><br/>
    <center><h2>Subcontractor</h2></center>

    <div></div>
   
    <div align="center">
       
        <div id="content">
            <table id="SubconInformation" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
                <tbody></tbody>
            </table>
            <table id="productTable" data-height="299" data-search="true" class="table table-bordered" data-click-to-select="true">
                <thead>
                    <tr>
                        <th data-sortable="true">Service</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>

        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myAddService">Add Service</button>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myAddSubcontractor">Add Subcontractor</button>

        <div class="modal fade" id="myAddService" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Item</h4>
                    </div>
                    <form action="EncodeItemServlet" method="POST">
                        <div class="modal-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Service<th>
                                    </tr>
                                </thead>
                                <tbody id ="dataTable1" >
                                    <tr> 
                                        <td><input type="checkbox" name="chk" /></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemCode" id="itemname"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="itemName" id="itemmodel"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="inventoryType" id="inventoryType"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <input type="hidden" name="suppliervalue" id="suppliervalue" value="">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <input type="button" class="btn btn-danger" value="Add Row" onclick="addRow('dataTable1')" />
                            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable1')" />
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal-dialog modal-lg" id="myAddSubcontractor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">Add Item</h4>
                    </div>
                    <form  method="POST" action="EncodeSupplierServlet">
                        <div class="modal-body">
                            <table>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th>Subcontractor ID</th>
                                        <th>Company Name</th>
                                        <th>Company  Address</th>
                                        <th>Company Contact Person</th>
                                        <th>Company Contact Number</th>
                                        <th>Service</th>
                                    </tr>
                                </thead>
                                <tbody id = "dataTable2">
                                    <tr>
                                        <td><input type="checkbox" name="chk" /></td>
                                        <td><input type="text" class="form-control" placeholder="" name="Subcontractorvalue" id="suppliervalue"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="companyName" id="companyName"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="companyAddress" id="companyAddress"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="contactPerson" id="contactPerson"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="contactNumber" id="contactNumber"></td>
                                        <td><input type="text" class="form-control" placeholder="" name="service" id="itemCode"></td>
                                    </tr>
                                </tbody> 
                            </table>  
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-danger" value="Add Row" onclick="addRow('dataTable2')" />
                            <input type="button" class="btn btn-danger" value="Delete Row" onclick="deleteRow('dataTable2')" />
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <br/><br/>

        <br/><br/>

        <a href="dashboard.jsp"><button type="button" class="btn btn-danger">Exit</button></a>
    </div>
    <script>
        
    </script>
</body>

</html>
