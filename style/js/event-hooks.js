var Hooks = {documentReady: []};


addHook = function(event, f) {
    Hooks[event].push(f);
}

runHooks = function(event) {
    hooks = Hooks[event];  // hooks is an array
    $.each(hooks, function(i, f) {f();});
}
