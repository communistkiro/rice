(function() {
    window.addEventListener("click", function(e) {
        if (
              e.button == 1 // for middle click
              //|| e.ctrlKey   // for ctrl + click
           ) {
            var new_uri = e.srcElement.href;
            if (new_uri) {
                e.stopPropagation();
                e.preventDefault();
                window.open(new_uri);
            }
        }
    }, false);
})();


function untarget() {
  var links = document.getElementsByTagName('a');
  Array.prototype.slice.call(links).forEach(function(anchor, index, arr) {
    if (anchor["target"] == "_blank")
      anchor.removeAttribute("target");
  });
}

window.onload = untarget;
