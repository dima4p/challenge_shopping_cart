$(document).on 'focus', "body.shopping_carts.show *", ->
  $.fn.current = $(this).attr('id')
  false

$(document).on 'change', "body.shopping_carts.show input[type='number']",  ->
  form = $(this).closest 'form'
  $.post document.URL, form.serialize(), null, 'script'

$(document).on 'turbolinks:load', ->
  if $("body.shopping_carts.show").length and $.fn.current and $.fn.current.length
    $("#" + $.fn.current).focus()
