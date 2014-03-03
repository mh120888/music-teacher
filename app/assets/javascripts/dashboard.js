$(function(){
  Navigation.init();
  bindPopstate();
  FinancesPage.init();
});


function bindPopstate() {
  $(window).bind("popstate", popstateAjax);
}

function popstateAjax() {
  $.ajax({
    method: "GET",
    url: location.href + "_partial"
  }).done(function(data) {
    if(!location.pathname == '/finances') {
      $('.content-wrapper').html(data);
      if(location.pathname == "/lesson") {
        LessonPage.init();
      }
    }
    console.log(location.href + "_partial");
  }).fail(function() {
    console.log("Popstate request failed");
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
    $('.metronome-link').on('ajax:success', addMetronome);
    $('.metronome-link').on('ajax:error', moduleError);

    $('.another-test-module-link').on('ajax:success', addModuleTwo);
    $('.another-test-module-link').on('ajax:error', moduleError);
  }

  function addMetronome(event, data) {
    Module.appendModule(data, 'metronome')
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

FinancesPage = (function(){
  function bindEvents() {
    $('.nav-finances').on('ajax:success', showFinances);
    $('.nav-finances').on('ajax:error', showError);
  }

  function showFinances(event, data) {
    history.pushState(null, "Finances", "/finances");
    $('.content-wrapper').html(data);
  }

  function showError() {
    console.log("Error for finances page fool");
  }

  function _init() {
    bindEvents();
  }

  return {
    init: _init
  }
}())