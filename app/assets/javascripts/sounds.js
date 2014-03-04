var TrackSearchForm = (function(){
  function bind(){
    $("#advanced-options").on("click", showOptions)
  }
  function _init(){
    bind()
  }
  function showOptions(event){
    event.preventDefault()
    $("#advanced-search").toggle()
  }
  return {
    init: _init
  }
}())

var TrackWidgetDisplay = (function(){
  function bind(){
    $(".play").on("ajax:success", showWidget)
  }

  function showWidget(event, data){
    $(this).html(data)
  }

  function _init(){
    bind()
  }

  return {
    init: _init
  }
}())

var ToggleMode = (function(){
  function bind(){
    $("#search").on("click", toggleSearch)
    $("#existing").on("click", toggleExisting)
  }

  function toggleSearch(){
    $('#search-tracks').show()
    $('#user-tracks').hide()
  }

  function toggleExisting(){
    $('#search-tracks').hide()
    $('#user-tracks').show()
  }

  function _init(){
    bind()
  }

  return {
    init: _init
  }
}())

$(function(){
  TrackSearchForm.init();
  TrackWidgetDisplay.init();
  ToggleMode.init()

  $(".play").click(function() {
    $( "div"+ "#" + $(this).attr('id')).animate({
        width: '+=400px', height: '+=250px'
    }, 1000);
  });






});






