$ ->
  $('.side-content').on 'click', '#close-menu, #menu-toggle', ->
    $('.menu-toggle, .menu-wrap').toggleClass("collapsed")
