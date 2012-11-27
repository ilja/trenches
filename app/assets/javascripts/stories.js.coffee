jQuery ->
  $('ul.storylist').on 'click', '.button[rel="edit-story"]', (e) ->
    e.preventDefault()
    url = $(this).attr "href"
    elm = $(this)
    $.get url, (data) ->
      console.log elm.closest('.storybody')
      elm.closest('.storybody').html data

  $('ul.storylist').on 'click', '.button[rel="save-story"]', (e) ->
    e.preventDefault()
    form = $('form.edit_story')
    elm = $(this)
    $.post form.attr('action'), form.serialize(), (data) ->
      elm.closest('li.story').replaceWith data

