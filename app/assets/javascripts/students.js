students = {
  init: function() {
    listStudents.init();
    newContact.init();
    viewContact.init();
    editContact.init();
    deleteContact.init();
  }
}


// $(function() {
//   students.init();
//   newContact.init();
//   viewContact.init();
//   editContact.init();
//   deleteContact.init();
// });


var listStudents = (function(){
  function _init(){
    $(".students-link").on('ajax:success', renderStudents);
  }

  function renderStudents(e, data) {
    console.log("asdfasdf")
    console.log(data)
    $('#module-area').html(data)
  }

  return {
    init: _init
  }
}());




var newContact = (function(){
  function bindEvents() {
    $('#new-contact a').on('ajax:success', renderNewContactForm);
    $('#new-contact a').on('ajax:error', showContactFormError);
    $('.contacts-module').on('ajax:success', 'form.new_contact', renderContactsIndex);
  }

  function renderNewContactForm(e, data) {
    $('#contact-form').html(data)
    $('#contacts-list').hide()
  }

  function showContactFormError(e, error) {
    alert('Something went wrong...sorry!');
  }

  function renderContactsIndex(e, data) {
    $('#contacts-list').html(data);
    $('#contacts-list').show()
    $('#contact-form').hide()
  }

  function showContactsIndexError(e, error) {
    alert('Something went wrong...sorry!');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var viewContact = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', '#contacts-list a.view', showContact);
    $('.contacts-module').on('ajax:error', '#contacts-list a.view', showViewContactError);
    $('#teacher-view').on("click", showTeacher)
  }

  function showContact(event, data) {
    console.log(data)
    $('#contact-show').html(data);
    $('#teacher').hide()
  }

  function showViewContactError(event, error) {
    alert("something broke...sorry!");
  }

  function showTeacher(){
    $('.submissions').show()
    $('#contact-show').empty()
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var editContact = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', 'a.edit-contact', renderEditForm)
    $('.contacts-module').on('ajax:error', 'a.edit-contact', renderEditContactError)
    $('.contacts-module').on('ajax:success', 'form.edit_contact', renderEditedContact);
    $('.contacts-module').on('ajax:error', 'form.edit_contact', renderEditError);
    $('.contacts-module').on('ajax:success', '#new_request', renderRequest)
  }

  function renderEditForm(event, data) {
    event.preventDefault();
    $('.contacts-module').html(data);
  }

  function renderEditContactError(event, xhr) {
    alert('Something Broke');
  }

  function renderEditedContact(event, data) {
    $('.contacts-module').html(data);
  }

  function renderEditError(event, xhr) {
    alert('Something Broke');
  }

  function renderRequest(event, data) {
    $("#new_request").get(0).reset()
    $('#pending').append(data)
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

var deleteContact = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', 'a.delete-contact', deleteContact);
    $('.contacts-module').on('ajax:error', 'a.delete-contact', showDeleteContactError);
  }

  function deleteContact(e, data) {
    window.location = '/users/' + data + '/contacts'
  }

  function showDeleteContactError(e, error) {
    alert('Something Broke');
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());

