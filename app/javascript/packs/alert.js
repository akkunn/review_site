window.addEventListener("turbolinks:load", function(){
  $(function(){
    $('.alert-alert').fadeOut(6000);  //４秒かけて消えていく
    $('.alert-notice').fadeOut(6000);  //４秒かけて消えていく
    $('.alert-success').fadeOut(6000);  //４秒かけて消えていく
    $('.alert-failure').fadeOut(6000);  //４秒かけて消えていく
  });
});
