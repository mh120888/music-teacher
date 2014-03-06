$(document).ready(function(){
  LandingModal.init();
})

var LandingModal  = (function() {
  function bindEvents() {
    $('a#signin-modal').on('ajax:success', renderLandingModal);
    $('a#signin-modal').on('ajax:error', renderModalError);
    $('#landing-content').on('click', 'a#close', removeLandingModal);
    $('a#signup-modal').on('ajax:success', renderLandingModal);
    $('a#signup-modal').on('ajax:error', renderModalError);
    $('#landing-content').on('click', 'a#close', removeLandingModal);
  }

  function renderLandingModal(event, data) {
    event.preventDefault();
    $('#landing-content').append(modalHTML());
    $('#modal #content').html("<a href='#' id='close'><i class='fa fa-times'></i></a>" + data);
    $('body').addClass('stop-scrolling');
  }

  function renderModalError (event, error) {
    event.preventDefault();
    $('#landing-content').append(modalHTML());
    $('#modal #content').html('We\'re having some technical difficulties right now.  Please try again shortly');
  }

  function modalHTML() {
    return "<div id='modal-container'><div id='overlay'></div><div id='modal'><div id='content'></div></div></div>";
  }

  function removeLandingModal(event) {
    event.preventDefault();
    $('#modal-container').empty();
    $('#modal-container').remove();
    $('body').removeClass('stop-scrolling');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init,
    bindEvents: bindEvents
  }
}());