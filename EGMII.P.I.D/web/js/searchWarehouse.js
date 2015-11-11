var x =true;
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
                url: '',
                dataType: 'json',
                data: {
                    productName: productName
                },
                success: function (data) {
                    if(x){
                     $('#ReplenishItem').append('<tr><th>Product Name</th><th>Color</th><th>Size</th><th>Quantity</th></tr>');
                        x=false;
                    }
                    $('#ReplenishItem').append('<tr><td><input type="hidden" name="subcon" value="'+ data[0].subconId +'"/></td></tr>');
                }
           });
        }
    });
}