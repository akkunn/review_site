window.addEventListener("turbolinks:load", function(){
  $('textarea.resize10').on('keydown', function(){
    let textarea = this;
    setTimeout(function(){
      textarea.style.cssText = 'height : 10.1rem;';
      textarea.style.cssText = 'height : ' + textarea.scrollHeight + 'px;';
    },0);
  });

  $('textarea.resize7').on('keydown', function(){
    let textarea = this;
    setTimeout(function(){
      textarea.style.cssText = 'height : 7.1rem;';
      textarea.style.cssText = 'height : ' + textarea.scrollHeight + 'px;';
    },0);
  });

  $('textarea.resize2').on('keydown', function(){
    let textarea = this;
    setTimeout(function(){
      textarea.style.cssText = 'height : 2.45rem;';
      textarea.style.cssText = 'height : ' + textarea.scrollHeight + 'px;';
    },0);
  });
});
