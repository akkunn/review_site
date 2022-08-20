window.addEventListener("turbolinks:load", function(){
  $(function() {
    $('.header-hidden-menu-close-open-button').on('click', function() {
      $('.header-hidden-menu-background').toggleClass('weak-visible');
      $('.header-hidden-menu-background').toggleClass('weak-hidden');
      $('.header-hidden-menu').toggleClass('header-hidden-menu-open');
      $('body').toggleClass('overflow-y-hidden');
    });
  });

  $(function() {
    $('.header-hidden-menu-background').on('click', function() {
      $('.header-hidden-menu-background').toggleClass('weak-visible');
      $('.header-hidden-menu-background').toggleClass('weak-hidden');
      $('.header-hidden-menu').removeClass('header-hidden-menu-open');
      $('body').removeClass('overflow-y-hidden');
    });
  });
});
