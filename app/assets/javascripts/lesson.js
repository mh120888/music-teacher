var Lesson = (function(){
  function bindEvents() {
    $('.metronome-link').on('ajax:success', addMetronome);
    $('.metronome-link').on('ajax:error', moduleError);

    $('.drone-link').on('ajax:success', addDrone);

    $('.sounds-link').on('ajax:success', showSounds);
    $('.sounds-link').on('click', returnSounds);

    $('.students-link').on('ajax:success', addStudents);



    $('.another-test-module-link').on('ajax:success', addModuleTwo);
    $('.another-test-module-link').on('ajax:error', moduleError);
  }

  function addStudents(event, data) {
    Module.appendModule(data, 'students')
  }

  function addMetronome(event, data) {
    Module.appendModule(data, 'metronome')
  }

  function addDrone(event, data) {
    Module.appendModule(data, 'drone')
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
