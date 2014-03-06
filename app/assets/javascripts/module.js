var Module = (function(){
  function bindEvents(moduleName) {
    var $module = $('.' + moduleName)
    $module.find('.module-delete-link').on('click', deleteModule);
    $module.find('.module-collapse-link').on('click', collapseModule);
    $module.find('.module-shift-link').on('click', moveModule);
  }

  function moveModule(event){
    $(this).closest('.module').css("margin-left", "10000px")
  }


  function deleteModule(event) {
    $(this).closest('.module').remove();
  }

  function collapseModule(event) {
    var $module = $(this).closest('.module');
    $module.find('.module-collapse').toggle( "fast" );
  }

  function bindDraggable() {
    $(".active-module").draggable({ containment: "parent", handle: ".module-header" });
  }

  function bindZIndex() {
    $(".module").on('mousedown', topOfStack);
  }

  function topOfStack() {
    var max = findMaxZIndex();
    var newMax = parseInt(max) + 1
    $(this).css('z-index', newMax);
  }

  function findMaxZIndex() {
    var max = 2
    $('.module').each( function(index, element){
      var elementZIndex = $(element).css('z-index');
      if( max < parseInt(elementZIndex) ) {
        max = elementZIndex;
      }
    });
    return max;
  }

  function newModule(data, moduleName) {
    var newModule = $('#master-module-template').clone().html(data).removeAttr('id').removeClass('hidden').addClass('active-module').addClass(moduleName);
    $('#module-area').append(newModule[0]);
    bindDraggable();
    bindZIndex();
    bindEvents(moduleName);
  }

  function _appendModule(data, moduleName) {
    if($("." + moduleName).length == 0) {
      newModule(data, moduleName);
    }
  }

  return {
    appendModule: _appendModule
  }
}());