var slice$ = [].slice;
define(function(require, exports){
  exports.log = function(){
    var args;
    args = slice$.call(arguments);
    return console.log.apply(console, args);
  };
});