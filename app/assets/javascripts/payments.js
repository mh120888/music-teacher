// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var PaymentGenerator = {
  init: function(){
    $('.new-payment').on("ajax:success", this.addPaymentButton)
  },

  addPaymentButton: function(event, data, status, xhr){
    $('#new-payment').html(data)
    $(".stripe-button-el span").text('Pay!')
  }
}

$(document).ready(function(){
  PaymentGenerator.init()
})

