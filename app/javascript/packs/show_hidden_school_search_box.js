  window.addEventListener("turbolinks:load", function(){
    $(function() {
      $('.school-search-box-apper-hidden').on('click', function() {
        $('.search-result-search-box').toggleClass('visible');
        $('.search-result').toggleClass('height38');
        $('.search-result').toggleClass('decrease-padding');
        $('.search-result').toggleClass('add-padding');
        $('.school-search-minus').toggleClass('visible');
        $('.school-search-plus').toggleClass('weak-hidden');
      });
    });
  });
