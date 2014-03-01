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

$(function(){
  TrackSearchForm.init();
  TrackWidgetDisplay.init();
});
