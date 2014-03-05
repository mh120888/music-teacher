Lesson = (function(){
  function bindEvents() {
    $('.metronome-link').on('ajax:success', addMetronome);
    $('.metronome-link').on('ajax:error', moduleError);
    $('.sounds-link').on('ajax:success', showSounds);

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
    Module.appendModule(data, 'soundcloud')
  }

  return {
    init: _init
  }
}());
