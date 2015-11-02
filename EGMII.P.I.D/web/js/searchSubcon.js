var i = 1;
var x = true;
function autoCompleteSubcon() {

    $("#subconName").devbridgeAutocomplete({
        serviceUrl: 'SearchSubconServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Suppplier',
        onSelect: function (event, ui) {
         var subconName = document.getElementById('subconName').value;
            $.ajax({
                type: 'POST',
                url: 'SetSubconServiceServlet',
                dataType: 'json',
                data: {
                    subconName: subconName
                },
                success: function (data) {
                    $('#dataSubconService tbody tr').remove();
                    $('#dataSubconService').append('<tr><th><input type="hidden" name="subcon" value="'+ data[0].subconId +'"/></th><th>Service</th></tr>');
                    for (var y = 0; y < data.length; y++) {
                        $('#dataSubconService').append('<tr> <td><input type="checkbox" name="checkbox"/></td> <td> <input type="text" name="service" value="' + data[y].service +'"/><input type="hidden" name="receivingStatus" value="pending"/> <input type="hidden" name="reconcileStatus" value="pending"/></td></tr>');
                    }
                }
            });
        }
    });
}