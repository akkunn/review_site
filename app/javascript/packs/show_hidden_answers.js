window.addEventListener("turbolinks:load", function(){
  let answers = gon.answers
  answers.forEach(function(element){
      $(".hidden-point-" + element.id).on('click', function() {
        $(".hidden-menu-" + element.id).toggleClass('fade-in');
        $(".hidden-menu-" + element.id).toggleClass('fade-out');
      });
  });
});
