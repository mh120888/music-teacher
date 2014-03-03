Module = (function(){
  function bindEvents() {
    $('.module-delete-link').on('click', deleteModule);
    $('.module-collapse-link').on('click', collapseModule);
  }

  function deleteModule(event) {
    $(this).closest('.module').remove()
  }

  function collapseModule(event) {
    $(this).closest('.module').find('.module-collapse').toggle( "fast" )
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
    var newModule = $('.module').clone().html(data).removeClass('hidden').addClass('active-module').addClass(moduleName);
    $('#module-area').append(newModule[0]);
    bindDraggable();
    bindZIndex();
    bindEvents();
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