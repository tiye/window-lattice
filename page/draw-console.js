var slice$ = [].slice;
define(function(require, exports){
  var tmpl, $, log, ls;
  tmpl = require('./tmpl').tmpl;
  window.tmpl = tmpl;
  window.$ = $ = require('jquery');
  log = require('./tool').log;
  window.ls = ls = require('./livescript-1.1.0.js').LiveScript;
  log(ls);
  window.puts = function(){
    var args;
    args = slice$.call(arguments);
    return $('#output').append("<pre>" + JSON.stringify.apply(JSON, args) + "</pre>");
  };
  window.putClear = function(){
    return $('#output').text("");
  };
  exports.drawConsole = function(){
    var input, output, showError;
    $('#console').hide();
    input = $(tmpl({
      "textarea/text": "terminal.."
    }));
    output = $(tmpl({
      "/output": "output here.."
    }));
    $('#console').append(input).append(output);
    $("body").keypress(function(e){
      var textElem, textLength;
      if (e.ctrlKey && !e.altKey) {
        if (e.keyCode === 2) {
          if (!window.atConsole) {
            $('#console').fadeIn();
            textElem = input[0];
            textLength = textElem.value.length;
            textElem.selectionStart = textLength;
            textElem.selectionEnd = textLength;
          } else {
            $('#console').fadeOut();
          }
          return window.atConsole = !window.atConsole;
        }
      }
    });
    log("binding key");
    input.keydown(function(e){
      var code, err;
      if (e.ctrlKey && !e.altKey) {
        if (e.keyCode === 13) {
          code = input.val();
          log(code);
          try {
            return ls.run(code);
          } catch (e$) {
            err = e$;
            return showError(err);
          }
        }
      }
    });
    return showError = function(info){
      return log(info);
    };
  };
});