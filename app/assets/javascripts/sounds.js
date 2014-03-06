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
    $("body").on("ajax:success",".form-play", showWidget)
  }

  function showWidget(event, data){
    $(this).html(data).addClass("opened")
    $(this).parent().append("<input name='commit' class='back' type='submit' value='Back!'>")
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
    $("#searching").on("click", toggleSearch)
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

var SearchDisplay = (function(){

  function bind(){
    $('#search').on("ajax:success", displayResults)
    $('#search').on("submit", displayLoading)
    $("body").on("click",".play", enlargeTrack)
    $("body").on("click",".back", revertResults)
  }

  function displayResults(e, data){
    $('#search-results').html(data)
  }

  function displayLoading(){
    $('#search-results').html("<img src='/assets/spin.gif' id='loading'>")
  }

  var backButton = "<input name='commit' class='back' type='submit' value='Back!'>"
  var replayButton ="<br><input name='commit' id='replay' type='submit' value='Play!' class='play replay'>"

  function enlargeTrack(){
    var content = $(this).parent()
    var container = $(this).parent().parent()
    content.children('br').remove()
    $(".track").hide()

    container.show().animate({
        width: '+=400px', height: '+=150px', marginLeft: "100px"
    }, 1000);
    content.children("iframe").animate({
        width: '+=300px', height: '+=150px'
    }, 1000).show()
     if (content.attr("class").indexOf("opened") != -1){
       container.append(backButton)
     }
     $(this).hide()
  }

  function revertResults(){
    var iframe = $(this).parent().children("form").children("iframe")
    var playForm = $(this).parent()
    playForm.animate({
        width: '-=400px', height: '-=150px', marginLeft: "10px"
    }, 1000);
    iframe.animate({
        width: '-=300px', height: '-=150px'
    }, 1000);
    $(".track").show()
    playForm.children(".back").remove()
    iframe.parent().append(replayButton)
  }

 function _init(){
    bind()
  }

  return {
    init: _init
  }
}())

Sounds = {
  init: function() {
    TrackSearchForm.init();
    TrackWidgetDisplay.init();
    ToggleMode.init()
    SearchDisplay.init()
  }
}





