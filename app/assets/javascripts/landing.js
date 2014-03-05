$(document).ready(function(){
  SigninModal.init();
})

var SigninModal  = (function() {
  function bindEvents() {
    $('a#signin-modal').on('click', renderSigninModal);
    $('#landing-content').on('click', 'a#close', removeSigninModal);
  }

  function renderSigninModal(event) {
    event.preventDefault();
    $('#landing-content').append(modalHTML());
    console.log('yay');
  }

  function modalHTML() {
    return "<div id='modal-container'><div id='overlay'></div><div id='modal'><div id='content'>No JavaScript Yet!<a href='#' id='close'>close</a></div></div></div>";
  }

  function removeSigninModal() {
    $('#modal-container').empty();
    $('#modal-container').remove();
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init,
    bindEvents: bindEvents
  }
}());