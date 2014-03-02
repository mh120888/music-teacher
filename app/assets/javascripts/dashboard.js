$(function(){
  Navigation.init();
  bindPopstate();
});


function bindPopstate() {
  $(window).bind("popstate", function() {
    $.ajax({
      method: "GET",
      url: location.href + "_partial"
    }).done(function(data) {
      $('.content-wrapper').html(data);
      console.log(location.href + "_partial");
    }).fail(function() {
      console.log("Popstate request failed");
    });
  });
}

Navigation = (function(){
  function _init() {
    Lesson.init();
  }

  return {
    init: _init
  }
}());


Lesson = (function(){
  function bindEvents() {
    $('.nav-lesson').on('ajax:success', showLesson);
    $('.nav-lesson').on('ajax:error', showError);
  }

  function showLesson(event, data) {
    history.pushState(null, "Lesson", "/lesson");
    $('.content-wrapper').html(data);
    LessonPage.init();
  }

  function showError(event, xhr, status, error) {
    console.log('Show lesson failed' + error);
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());


LessonPage = (function(){
  function bindEvents() {
    $('.test-module-link').on('ajax:success', addModuleOne);
    $('.test-module-link').on('ajax:error', moduleError);

    $('.another-test-module-link').on('ajax:success', addModuleTwo);
    $('.another-test-module-link').on('ajax:error', moduleError);
  }

  function addModuleOne(event, data) {
    Module.appendModule(data, 'test-module')
  }

  function addModuleTwo(event, data) {
    Module.appendModule(data, 'another-test-module')
  }

  function moduleError(event, xhr, status, error) {
    console.log('Create module failed' + error);
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}());