$(function() {
  newContact.init();
});

var newContact = (function(){
  function bindEvents() {
    $('#new-contact').on('click', toggleHidden);
    $('.new-contact-form form').on('ajax:success', addContact);
    $('.new-contact-form form').on('ajax:error', showContactError);
  }

  function toggleHidden(event) {
    event.preventDefault;
    $('.new-contact-form').toggleClass('hidden');
    $('.contacts-list').css('display', 'none');
  }

  function addContact(e, data) {
    $('.new-contact-form').html(data);
  }

  function showContactError(e, error) {
    $('.new-contact-form .error').html(error)
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var showContact = (function(){
  function bindEvents() {
    $('')
  }

  function toggleHidden(event) {
    event.preventDefault;

  }

  function addContact(e, data) {

  }

  function showContactError(e, error) {

  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());