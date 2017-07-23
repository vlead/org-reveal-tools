addHook('documentReady', 
    function() {
        $.each($("#outreach-status td").filter(".org-right"), 
               function(i, el) {
                   el.innerText = addCommas(el.innerText);});
    }
);

addHook('documentReady', 
    function() {
	$("#date").text(new Date().toLocaleString());
    }
);
    

$(document).ready(function () {runHooks('documentReady');});
