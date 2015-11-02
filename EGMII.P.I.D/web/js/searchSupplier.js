var i = 1;
var x = true;
function autoCompleteSupplier() {
    $("#supplierName").devbridgeAutocomplete({
        serviceUrl: 'SearchSupplierServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Suppplier',
    });
}

function autoCompleteSupplierItem() {
    var supplierName = document.getElementById('supplierName').value;
    if (supplierName == "") {
        window.alert("Please Input Supplier");
        $('input:text').focus(
                function () {
                    $('#itemNameSupplier').val('');
                });
    } else {
        $("#itemNameSupplier").devbridgeAutocomplete({
            serviceUrl: 'SearchItemSuppliersServlet',
            dataType: "json",
            params: {
                supplierName1: supplierName},
            type: 'POST',
            showNoSuggestionNotice: true,
            noSuggestionNotice: 'No Exsiting Item',
        });
    }
}
function chk() {
    if (i > 1) {
        var itemNameSupplier = document.getElementById('itemNameSupplier').value;
        $("#data tbody tr").each(function () {
            var $this = $(this);
            var chk = $this.find('[id="itemName\\[\\]"]').val();
            if (itemNameSupplier == chk) {
                x = false;
            }
        }
        );
    }

    return x;
}

function getSupplierItem() {
    x = true;
    x = chk();
    var itemNameSupplier = document.getElementById('itemNameSupplier').value;
    var supplierName = document.getElementById('supplierName').value;

    if (x == true) {
        $.ajax({
            url: "SetSupplierItemServlet",
            type: 'POST',
            dataType: "json",
            data: {
                itemNameSupplier: itemNameSupplier,
                supplierName: supplierName
            },
            success: function (data) {
                if (data[0] == null) {
                    window.alert("Please Enter Item / Supplier Name");
                    $('input:text').focus(
                            function () {
                                $('#itemNameSupplier').val('');
                            });
                }
                
                else if (i == 1) {
                    $('#data').append('<tr><th><input type="hidden" name="supplierId" value="' + data[0].supplier + '"/></th><th>Item Name</th> <th> Unit Price</th> <th>Quantity</th> <th>Total Quantity Price </th> <th>Note</th></tr>');
                    i++;
                    $('#supplierName').attr("disabled", "disabled");
                }
                if (data[0] != null) {
                    $('#data').append('<tr class="trclass"><td> <input type="checkbox" name="chk" /> </td>\n\
                    <td> <input type="hidden" name ="itemCode" value="' + data[0].itemCode + '" />\n\
                      <input type="text" class="transparentBg cellWidth readonlyWhite" readonly id= "itemName[]" value="' + data[0].itemName + '"/> </td>\n\
                    <td><input type="text" class="transparentBg readonlyWhite" readonly style="width:60px;" id="unitPrice[]" name = "unitPrice" value="' + data[0].unitPrice + '"/></td>\n\
                     <td> <input type="number" class="transparentBg" style="width:60px;" id="volumeQty[]" name="volumeQty" onChange="SolveTQP();"  onkeypress="return event.charCode >= 48 && event.charCode <= 57"/> </td>\n\
                     <td><input type="text" class="transparentBg cellWidth readonlyWhite" readonly name="Total Quantity Price" id="TQP[]"  /></td>\n\
                     <td><input type="hidden" class="transparentBg cellWidth" name="receivingStatus" value="pending" />\n\
                     <input type="hidden" name = "reconcileStatus" value="pending" />\n\
                      <input type="text" class="transparentBg cellWidth" name = "note"/></td>' + '</tr>');
                    document.getElementById("total").style.visibility = 'visible';
                }

            }, error: function (XMLHttpRequest, textStatus, exception) {
                alert(XMLHttpRequest.responseText);
            }
        });
    } else {
        window.alert("item Already Added");
        $('input:text').focus(
                function () {
                    $('#itemNameSupplier').val('');
                });

    }
}


function SolveTQP() {
    $(".trclass").each(function () {
        var $this = $(this);
        var unitPrice = parseInt($this.find('[id="unitPrice\\[\\]"]').val());
        var volumeQty = parseInt($this.find('[id="volumeQty\\[\\]"]').val());
        var STotal = unitPrice * volumeQty;
        $this.find('[id="TQP\\[\\]"]').val(STotal);
        SolveTotal();
    });
    return false;
}


function SolveTotal() {
    var STotal = 0;
    $(".trclass").each(function () {
        var $this = $(this);
        var TQP = parseInt($this.find('[id="TQP\\[\\]"]').val());
        STotal = STotal + TQP;
        document.getElementById('total1').value = STotal;
    }
    );

    return false;
}