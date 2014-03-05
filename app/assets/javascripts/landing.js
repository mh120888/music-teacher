$(document).ready(function(){
  SigninModal.init();
  SignupModal.init();
})

var SigninModal  = (function() {
  function bindEvents() {
    $('a#signin-modal').on('ajax:success', renderSigninModal);
    $('a#signin-modal').on('ajax:error', renderModalError);
    $('#landing-content').on('click', 'a#close', removeSigninModal);
  }

  function renderSigninModal(event, data) {
    event.preventDefault();
    $('#landing-content').append(modalHTML());
    $('#modal #content').html(data + "<a href='#' id='close'>close</a>");
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

  function removeSigninModal(event) {
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

var SignupModal  = (function() {
  function bindEvents() {
    $('a#signup-modal').on('ajax:success', renderSignupModal);
    $('a#signup-modal').on('ajax:error', renderModalError);
    $('#landing-content').on('click', 'a#close', removeSignupModal);
  }

  function renderSignupModal(event, data) {
    event.preventDefault();
    $('#landing-content').append(modalHTML());
    $('#modal #content').html(data + "<a href='#' id='close'>close</a>");
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

  function removeSignupModal(event) {
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



