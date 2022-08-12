window.addEventListener("turbolinks:load", function(){
  $('textarea.resize10').on('keydown', function(){
    var textarea = this;
    setTimeout(function(){
      textarea.style.cssText = 'height : 10.1rem;';
      textarea.style.cssText = 'height : ' + textarea.scrollHeight + 'px;';
    },0);
  });
});
