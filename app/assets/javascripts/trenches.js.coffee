# coffee script yeah!

$ ->


  $(document).bind 'end.pjax', ->
    title = $('[data-pjax-container]').find('[data-header-title]').remove().text()
    $('div#title h1').html title

  $('#sortable').sortable
    update: ->
      $.ajax
        type: 'post'
        data: $('#sortable').sortable('serialize', {attribute: 'id'})
        dataType: 'script'
        complete: ->
          $('#storylist').effect('highlight')
        url: $('#sortable').attr("data-url")

  $('#sortable').disableSelection()

  $('div.expand').live 'click', ->
    storybody = $(this).parents("li.story").children('.storybody')
    if storybody.css('display') == 'none'
      $(this).find("img").attr src:"/assets/close.png"
    else
      $(this).find("img").attr src:"/assets/open.png"
    storybody.toggle('fast')

  sortable_settings = {items: "li:not(.not-sortable)", connectWith: ".connectedSortable"  }
  $("#sortable-backlog, #sortable-sprintlog").sortable(sortable_settings).disableSelection()

  $("#sortable-backlog").sortable
    update: ->
      $.ajax
        type: 'post'
        data: $('#sortable-backlog').sortable('serialize', {attribute: 'id'})
        dataType: 'script'
        complete: ->
          $('#sortable-backlog').effect('highlight')
        url: $('#sortable-backlog').attr("data-url")

  $("#sortable-sprintlog").sortable
    update: ->
      $.ajax
        type: 'post'
        data: $('#sortable-sprintlog').sortable('serialize', {attribute: 'id'})
        dataType: 'script'
        complete: ->
          $('#sortable-sprintlog').effect('highlight')
        url: $('#sortable-sprintlog').attr("data-url")
