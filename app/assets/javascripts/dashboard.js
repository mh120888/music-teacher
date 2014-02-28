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
  function bindDraggable() {
    $( ".draggable" ).draggable();
  }

  function _newModule() {
    return $('.module').clone();
  }

  function _init() {
    bindDraggable();
  }

  return {
    init: _init,
    newModule: _newModule
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
    var newModule = Module.newModule();
    debugger
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