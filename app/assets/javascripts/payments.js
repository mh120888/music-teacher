$(document).ready(function(){
  PaymentGenerator.init()
})

var PaymentGenerator = {
  init: function(){
    $('.new-payment').on("ajax:success", this.addPaymentButton)
  },

  addPaymentButton: function(event, data, status, xhr){
    $('#new-payment').html(data)
    $(".stripe-button-el span").text('Pay!')
  }
}