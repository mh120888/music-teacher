students = {
  init: function() {
    // listStudents.init();
    viewContact.init();
    editAssignmnet.init();
  }
}


// $('#contact-box').animate({
//         height: '-=540px'
//     }, 1000)


var viewContact = (function(){
  function bindEvents() {
    $('.students').on('ajax:success', 'a.view', showContact);
    $('.students').on('ajax:error', '#students-list a.view', showViewContactError);
    $('#teacher-view').on("click", showTeacher)
  }

  function showContact(event, data) {
    $('.student').remove()
    $('#students-mod').append("<div id='contact-show'></div>")
    var student = $('#contact-show').html(data);
    removeParent(student)
    $('#contacts-box').animate({
        height: '400px', marginLeft: "90px"
    }, 500)
    $('#teacher').hide()
    $('#teacher-view').show()
  }

  function showViewContactError(event, error) {
    alert("something broke...sorry!");
  }

  function showTeacher(){
    $('.submissions').show()
    $('#contact-show').empty()
    $('#contacts-box').animate({
        height: '750px', marginLeft: "30px"
    }, 500)
    $('.student').remove()
    $('#students-mod').append("<div id='contact-show'></div>")
    $('#teacher-view').hide()
  }

  function removeParent(selector){
    var cnt = $(selector).contents();
    $(selector).replaceWith(cnt);
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
    $('.students').on('ajax:success', '#new_request', renderRequest)
  }

  function renderRequest(event, data) {
    $("#new_request").get(0).reset()
    $('#pending').append(data)
    $("h3."  + $("#request-button").attr("class").replace( /^\D+/g, '')).click()
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());
