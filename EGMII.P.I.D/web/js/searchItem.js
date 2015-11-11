var i = 1;
var x = true;

var z = 1;
var y = true;
/**
 * Search item
 * @returns {undefined}
 */
function autoComplete() {
    $("#itemNameSearch").devbridgeAutocomplete({
        serviceUrl: 'SearchItemServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Item'
    });
}

function chk() {
    if (i > 1) {
        var itemName = document.getElementById('itemNameSearch').value;
        $("#thisTable tbody tr").each(function () {
            var $this = $(this);
            var chk = $this.find('[id="itemName\\[\\]"]').val();
            if (itemName == chk) {
                x = false;
            }
        }
        );
    }

    return x;
}

function getItem() {
    x = true;
    x = chk();
    var itemName = document.getElementById('itemNameSearch').value;
    if (x == true) {
        $.ajax({
            url: "SetItemServlet",
            type: 'POST',
            dataType: "json",
            data: {
                itemName: itemName
            },
            success: function (data) {

                if (i == 1) {
                    $('#dataTable').append('<tr> <th ></th>  \n\
                <th style="vertical-align: middle">Item Name</th> \n\
                <th style="vertical-align: middle">Consumption</th>\n\
                <th style="vertical-align: middle">Unit Measurement</th></tr>');
                    i++;
                }

                $('#dataTable').append('<tr> \n\
                                        <td ><input type="checkbox" name="chk" /></td>\n\
                                        <td><input type="hidden" name = "itemCode" id="itemCode[]" value="' + data[0].itemCode + '"/> \n\
                                             <input type="text" class="transparentBg" readonly id="itemName[]" name = "itemName" value="' + data[0].itemName + '"/></td> \n\
                                        <td><input type="number" class="form-control inputSize" value="0"  min="1" id="itemConsumption[]" name="itemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td> \n\
                                        <td><input class="transparentBg" name="unitMeasurement" readonly id="unitMeasurement[]" value="' + data[0].unitMeasurement + '" /> </td>'
                        + '</tr>');
                document.getElementById("buttons").style.visibility = 'visible';

            }, error: function (XMLHttpRequest, textStatus, exception) {
                alert(XMLHttpRequest.responseText);
            }
        });
    }
    else {
        window.alert("item Already Added");
        $('input:text').focus(
                function () {
                    $('#itemNameSearch').val('');
                });
    }

}

/**
 * Search Fabrics
 */
function autoCompleteFabric() {
    $("#fabricNameSearch").devbridgeAutocomplete({
        serviceUrl: 'SearchFabricItemServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Fabric'
    });
}

function chkFabric() {
    if (z > 1) {
        var itemName = document.getElementById('fabricNameSearch').value;
        $("#thisTableFabric tbody tr").each(function () {
            var $this = $(this);
            var chk = $this.find('[id="fabricName\\[\\]"]').val();
            if (itemName == chk) {
                y = false;
            }
        }
        );
    }

    return y;
}

function getFabricItem() {
    y = true;
    y = chkFabric();
    var itemName = document.getElementById('fabricNameSearch').value;
    var productType = document.getElementById('productType').value;
    if (y == true) {
        $.ajax({
            url: "SetFabricServlet",
            type: 'POST',
            dataType: "json",
            data: {
                itemName: itemName
            },
            success: function (data) {

                if (z == 1) {
                    $('#dataTableFabric').append('<tr> <th></th>\n\
                                                 <th>Fabric Name</th>     \n\
                                                 <th style="vertical-align: middle">Size</th> \n\
                                                 <th style="vertical-align: middle">Consumption</th>\n\
                                                 <th style="vertical-align: middle">Unit Measurement</th>\n\
                                                 </tr>');
                    z++;
                }
                if (productType === "shirt") {
                    $('#dataTableFabric').append('<tr> \n\
                                             <td rowspan="6"><input type="checkbox" name="chk" /></td>\n\
                                             <td rowspan="6"><input type="hidden" name = "fabricCode" id="fabricCode[]" value="' + data[0].itemCode + '"/> \n\
                                             <input type="text" class="transparentBg" readonly id="fabricName[]" name = "itemName" value="' + data[0].itemName + '"/></td> \n\\n\
                                             </tr> \n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="XS" type="text"  name="size" readonly /></td>\n\\n\
                                                <td><input  class="form-control inputSize" value="0" type="number"  id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            <td rowspan="5"><input class="transparentBg inputSize" name="unitMeasurementfabric" id="unitMeasurement[]" value="' + data[0].unitMeasurement + '" /> </td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="S" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number"  id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="M" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="L" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="XL" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number"  id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                                  '
                            + '</tr>');
                    document.getElementById("buttonsFabric").style.visibility = 'visible';
                }
                else if (productType === "pants") {
                    $('#dataTableFabric').append('\
                                            <tr> \n\
                                             <td rowspan="11"><input type="checkbox" name="chk" /></td>\n\
                                             <td rowspan="11"><input type="hidden" name = "fabricCode" id="fabricCode[]" value="' + data[0].itemCode + '"/> \n\
                                             <input type="text" class="transparentBg" readonly id="fabricName[]" name = "fabricName" value="' + data[0].itemName + '"/></td> \n\\n\
                                             </tr> \n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="28" type="text"  name="size" readonly /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            <td rowspan="10"><input class="transparentBg inputSize" name="unitMeasurementfabric" id="unitMeasurement[]" value="' + data[0].unitMeasurement + '" readonly /> </td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="29" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="30" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                             <tr>\n\
                                                <td><input class="transparentBg inputSize" value="31" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="32" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="33" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="34" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="36" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="38" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\\n\
                                            <tr>\n\
                                                <td><input class="transparentBg inputSize" value="40" type="text"  name="size" readonly  /></td>\n\\n\
                                                 <td><input class="form-control inputSize" value="0" type="number" min="1" id="itemConsumption[]" name="fabricItemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td>\n\
                                            </tr>\n\
                                                  ');
                    document.getElementById("buttonsFabric").style.visibility = 'visible';

                }
            }, error: function (XMLHttpRequest, textStatus, exception) {
                alert(XMLHttpRequest.responseText);
            }
        });
    }
    else {
        window.alert("Fabric Already Added");
        $('input:text').focus(
                function () {
                    $('#fabricNameSearch').val('');
                });
    }

}


//function viewModal() {
//    var productID = document.getElementById('productID').value;
//    var sizeName = document.getElementById('sizeName').value;
//
//
//    document.getElementById('productIDModal').value = productID;
//    document.getElementById('sizeTypeModal').value = sizeName;
//
//
//    eraseModal();
//
//    $('#dataTableModal').append('<tr>  \n\
//                <th style="vertical-align: middle">Item Name</th> \n\
//                <th style="vertical-align: middle">Consumption</th>\n\
//                <th style="vertical-align: middle">Unit Measurement</th></tr>');
//
//    $("#dataTable tr").each(function () {
//        var $this = $(this);
//        var itemCode = $this.find('[id="itemCode\\[\\]"]').val();
//        var itemName = $this.find('[id="itemName\\[\\]"]').val();
//        console.log(itemName);
//        var consume = $this.find('[id="itemConsumption\\[\\]"]').val();
//        console.log(consume);
//        var unitMeasurement = $this.find('[id="unitMeasurement\\[\\]"]').val();
//        console.log(unitMeasurement);
//
//
//        if (!itemName == "") {
//            $('#dataTableModal').append('<tr>\n\
//                        <td><input type = "hidden" name = "itemCodeModal" value="' + itemCode + '">\n\
//                        <input type = "text" name = "itemNameModal" readonly class="transparentBg readonlyWhite" value="' + itemName + '"></td>\n\
//                        ' + itemName +
//                    '<td><input type = "text" name="itemConsumptionModal" readonly class="transparentBg readonlyWhite" value="' + consume + '"></td>\n\
//                        <td><input type = "text" name="unitMeasurementModal" readonly class="transparentBg readonlyWhite" value="' + unitMeasurement + '"></td></tr>');
//
//        }
//
//    });
//
//}

//function eraseModal() {
//    var Parent = document.getElementById('dataTableModal');
//    while (Parent.hasChildNodes()) {
//        Parent.removeChild(Parent.firstChild);
//    }
//}
