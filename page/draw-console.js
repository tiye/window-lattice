define(function(require, exports){
  var tmpl, $;
  tmpl = require('./tmpl').tmpl;
  $ = require('jquery');
  exports.drawConsole = function(){
    var json, input, log;
    $('#console').hide();
    json = {
      "textarea/text": "Demo in Terminal"
    };
    input = $(tmpl(json));
    $('#console').append(input);
    log = require('./tool').log;
    return $("body").keypress(function(e){
      log(e.keyCode);
      if (e.ctrlKey && !e.altKey) {
        if (e.keyCode === 2) {
          if (!window.atConsole) {
            $('#console').fadeIn();
          } else {
            $('#console').fadeOut();
          }
          window.atConsole = !window.atConsole;
          return log("ok");
        }
      }
    });
  };
});