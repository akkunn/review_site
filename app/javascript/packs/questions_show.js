window.addEventListener("turbolinks:load", function(){
  const app = Vue.createApp({
    data: () => ({
      show: true
    })
  })
  app.mount('#question--show')
});
