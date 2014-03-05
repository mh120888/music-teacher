var AudioAssets = {}

var Metronome = (function(){

  function setContext() {
    try {
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      AudioAssets.context = new AudioContext();
    }
    catch(e) {
      alert('Web Audio API is not supported in this browser');
    }
  }

  function loadClick() {
    var request = new XMLHttpRequest();
    request.open('GET', '/audios/click.mp3', true);
    request.responseType = 'arraybuffer';
    request.onload = function() {
      AudioAssets.context.decodeAudioData(request.response, function(buffer) {
        AudioAssets.click = buffer;
        bindSounds();
      });
    }
    request.send();
  }

  function bindSounds() {
    $('.dashboard-wrapper').on('click', '.metronome-click', playClick);
  }

  function playClick(event) {
    event.preventDefault();
    var startTime = AudioAssets.context.currentTime + 0.100;
    var tempo = 80; // BPM (beats per minute)
    var eighthNoteTime = (60 / tempo) / 2;

    for (var bar = 0; bar < 2; bar++) {
      var time = startTime + bar * 8 * eighthNoteTime;

      for (var i = 0; i < 8; ++i) {
        playSound(AudioAssets.click, time + i * eighthNoteTime);
      }
    }
  }

  function playSound(buffer, time) {
    var source = AudioAssets.context.createBufferSource();
    source.buffer = buffer;
    source.connect(AudioAssets.context.destination);
    source.start(time);
  }

  function _init() {
    setContext();
    loadClick();
  }

  return {
    init: _init,
  }
}());
