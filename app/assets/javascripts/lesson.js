var Lesson = (function(){
  function bindEvents() {
    $('.metronome-link').on('ajax:success', addMetronome);
    $('.metronome-link').on('ajax:error', moduleError);
    $('.sounds-link').on('ajax:success', showSounds);
    $('.sounds-link').on('click', returnSounds);
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

  function showSounds(event, data){
    // $(".soundcloud").css("margin-left", "0px")
    if ( !$(".soundcloud")[0]){
      Module.appendModule(data, 'soundcloud')
    }
    // else{
    //   return true
    // }
  }

  function returnSounds(){
    $(".soundcloud").css("margin-left", "0px")
  }

  return {
    init: _init
  }
}());


