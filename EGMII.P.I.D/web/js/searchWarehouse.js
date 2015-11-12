var x = true;
function autoCompleteWarehouseInventory() {
    $("#productName").devbridgeAutocomplete({
        serviceUrl: 'searchWarehouseInv',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Product',
        onSelect: function (event, ui) {
            var productName = document.getElementById('productName').value;
            $.ajax({
                type: 'POST',
                url: 'SetWarehouseInvServlet',
                dataType: 'json',
                data: {
                    productName: productName
                },
                success: function (data) {
                    if (x) {
                        $('#ReplenishItem').append('<tr><th>Product Name</th><th>Color</th><th>Size</th><th>Current Quantity</th></tr>');
                        x = false;
                    }
                   //code appending etc
                    $('#ReplenishItem').append('<tr><td><input type="hidden" name="" value="'+ data[0].itemCode +'"/>\n\
                           <input type="text" value="'+ data[0].productName +'"/> \n\
                           </td><td><select name="color">'  + data.map(function(opt) { return '<option value="'+ opt.color +'">'+ opt.color + '</option>' }).join("") + '</select>\n\
                           </td> <td><select name="size">'  + data.map(function(opt) { return '<option value="'+ opt.size +'">'+ opt.size + '</option>' }).join("") + '</select>\n\
                           </td><td><select name="size">'  + data.map(function(opt) { return '<option value="'+ opt.qty +'">'+ opt.qty + '</option>' }).join("") + '</select>\n\
                           </td></tr>');
                }
            });
        }
    });
}