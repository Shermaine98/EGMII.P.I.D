function autoCompleteSubcon() {
    $("#subconName").devbridgeAutocomplete({
        serviceUrl: 'SearchSubconServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Suppplier',
        onSelect: function (event, ui) {
            console.log("SELECTTT");
         var subconName = document.getElementById('subconName').value;
            $.ajax({
                type: 'POST',
                url: 'SetSubconInfoServlet',
                dataType: 'json',
                data: {
                    subconName: subconName
                },
                success: function (data) {
                    console.log("subconName" + data[0].subconName);
                    $('#dataSubcon tbody tr').remove();
                    $('#dataSubcon').append('<tr><th><input type="text" name="subcon" value="'+ data[0].subconId +'"/></th><th>Service</th></tr>');
                }
           });
        }
    });
}