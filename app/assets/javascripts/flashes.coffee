$ ->
  $("#flash").on 'click', (event) ->
    $(event.target).stop(true).slideUp ->
      $("#flash").remove()

  $("#flash").find('[class^=flash]').slideDown().delay(3000).slideUp ->
    $("#flash").remove()
