jQuery ->
  $('.button-group').on 'click', '.button[rel="edit-story"]', (e) ->
    e.preventDefault()
    url = $(this).attr "href"
    elm = $(this)
    $.get url, (data) ->
      #console.log elm.closest('.storybody')
      elm.closest('.storybody').html data
