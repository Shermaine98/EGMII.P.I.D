var i = 1;
var x = true;
function autoCompleteSubcon() {

    $("#subconName").devbridgeAutocomplete({
        serviceUrl: 'SearchSubconServlet',
        type: 'POST',
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'No Exsiting Suppplier'
    });
}