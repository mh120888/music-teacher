students = {
  init: function() {
    listStudents.init();
    viewContact.init();
    editAssignmnet.init();
  }
}


var listStudents = (function(){
  function _init(){
    $(".students-link").on('ajax:success', renderStudents);
  }

  function renderStudents(e, data) {
    $('#module-area').html(data)
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

var editAssignmnet = (function(){
  function bindEvents() {
    $('.contacts-module').on('ajax:success', '#new_request', renderRequest)
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
