$(function(){
  Navigation.init();
});

Navigation = (function(){
  function _init() {
    Lesson.init();
  }

  return {
    init: _init
  }
}());

Module = (function(){
  function _bindDraggable() {
    $(".active-module").draggable({ containment: "parent", handle: ".module-header" });
  }

  function _newModule(data, moduleName) {
    var newModule = $('.module').clone().html(data).removeClass('hidden').addClass('active-module').addClass(moduleName);
    $('#module-area').append(newModule[0]);
    Module.bindDraggable();
  }

  return {
    newModule: _newModule,
    bindDraggable: _bindDraggable
  }
}());

Lesson = (function(){
  function bindEvents() {
    $('.nav-lesson').on('ajax:success', showLesson);
    $('.nav-lesson').on('ajax:error', showError);
  }

  function showLesson(event, data) {
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
    $('.metronome').on('ajax:success', metronomeModule);
    $('.metronome').on('ajax:error', moduleError);
  }

  function metronomeModule(event, data) {
    var moduleName = 'metronome-module';
    if($("." + moduleName).length == 0) {
      Module.newModule(data, moduleName);
    }
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