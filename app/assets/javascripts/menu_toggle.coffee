$ ->
  $('body').on 'click', '#menu-toggle, #close-menu', (event) ->
    event.preventDefault()
    $('.menu-wrap').toggleClass("closed")
    $('#menu-toggle').toggleClass("close")
