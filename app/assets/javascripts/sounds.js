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
    // $("body").on("click", ".", playWidget)
    $("body").on("ajax:success",".form-play", showWidget)
  }

  function showWidget(event, data){
    $(this).html(data).addClass("opened")
    $(this).parent().append("<input name='commit' class='back' type='submit' value='Back!'>")
  }

  function playWidget(event, data){
    $(this).submit()
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


  function enlargeTrack(){
    $('.replay').parent().children('br').remove()
    $(".track").hide()
    $(this).parent().parent().show().animate({
        width: '+=400px', height: '+=150px', marginLeft: "100px"
    }, 1000);
    $(this).parent().children("iframe").animate({
        width: '+=300px', height: '+=150px'
    }, 1000).show()
     if ($(this).parent().attr("class").indexOf("opened") != -1){
       $(this).parent().parent().append("<input name='commit' class='back' type='submit' value='Back!'>")
     }
     $(this).hide()
  }

  function revertResults(){
    var iframe = $(this).parent().children("form").children("iframe")
    if (!iframe) {
      return true
    }
    $(".track").show()
    $(this).parent().animate({
        width: '-=400px', height: '-=150px', marginLeft: "10px"
    }, 1000);

    iframe.animate({
        width: '-=300px', height: '-=150px'
    }, 1000);
    $(this).parent().children(".back").remove()
    iframe.parent().append("<br><input name='commit' id='replay' type='submit' value='Play!' class='play replay'>")
    if ( !iframe.parent().children("#replay") ) {
      iframe.parent().append("<br><input name='commit' id='replay' type='submit' value='Play!' class='play replay'>")
    }
  }

 function _init(){
    bind()
  }

  return {
    init: _init
  }
}())


// $(function(){
//   TrackSearchForm.init();
//   TrackWidgetDisplay.init();
//   ToggleMode.init()
//   SearchDisplay.init()
// });

Sounds = {
  init: function() {
    TrackSearchForm.init();
    TrackWidgetDisplay.init();
    ToggleMode.init()
    SearchDisplay.init()
  }
}





