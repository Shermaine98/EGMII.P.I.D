var i = 1;
var x = true;
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

                $('#dataTable').append('<tr> <td ><input type="checkbox" name="chk" />\n\
                                                        </td>\n\
                                                        <td>\n\
                    <input type="hidden" name = "itemCode" id="itemCode[]" value="' + data[0].ItemCode + '"/> \n\
                 <input type="text" class="transparentBg" readonly id="itemName[]" name = "itemName" value="' + data[0].itemName + '"/></td> \n\
                <td><input class="transparentBg" value="0" type="number" min="1" id="itemConsumption[]" name="itemConsumption" onkeypress="return event.charCode >= 48 && event.charCode <= 57"  /></td> \n\
            <td><input class="transparentBg" name="unitMeasurement" id="unitMeasurement[]" value="'+data[0].unitMeasurement +'" /> </td>'
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

function viewModal() {
    var productID = document.getElementById('productID').value;
    var sizeName = document.getElementById('sizeName').value;


    document.getElementById('productIDModal').value = productID;
    document.getElementById('sizeTypeModal').value = sizeName;


    eraseModal();

    $('#dataTableModal').append('<tr>  \n\
                <th style="vertical-align: middle">Item Name</th> \n\
                <th style="vertical-align: middle">Consumption</th>\n\
                <th style="vertical-align: middle">Unit Measurement</th></tr>');

    $("#dataTable tr").each(function () {
        var $this = $(this);
        var itemCode = $this.find('[id="itemCode\\[\\]"]').val();
        var itemName = $this.find('[id="itemName\\[\\]"]').val();
        console.log(itemName);
        var consume = $this.find('[id="itemConsumption\\[\\]"]').val();
        console.log(consume);
        var unitMeasurement = $this.find('[id="unitMeasurement\\[\\]"]').val();
        console.log(unitMeasurement);


        if (!itemName == "") {
            $('#dataTableModal').append('<tr>\n\
                        <td><input type = "hidden" name = "itemCodeModal" value="' + itemCode + '">\n\
                        <input type = "text" name = "itemNameModal" readonly class="transparentBg readonlyWhite" value="' + itemName + '"></td>\n\
                        ' + itemName +
                    '<td><input type = "text" name="itemConsumptionModal" readonly class="transparentBg readonlyWhite" value="' + consume + '"></td>\n\
                        <td><input type = "text" name="unitMeasurementModal" readonly class="transparentBg readonlyWhite" value="' + unitMeasurement + '"></td></tr>');

        }

    });

}

function eraseModal() {
    var Parent = document.getElementById('dataTableModal');
    while (Parent.hasChildNodes()) {
        Parent.removeChild(Parent.firstChild);
    }
}
