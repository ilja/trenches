jQuery ->
  $('.button-group').on 'click', '.button[rel="edit-story"]', (e) ->
    e.preventDefault()
    url = $(this).attr "href"
    elm = $(this)
    $.get url, (data) ->
      elm.closest('.storybody').html data

  $('li.story').on 'click', '.button[rel="save-story"]', (e) ->
    e.preventDefault()
    form = $('form.edit_story')
    elm = $(this)
    $.post form.attr('action'), form.serialize(), (data) ->
      elm.closest('li.story').replaceWith data

