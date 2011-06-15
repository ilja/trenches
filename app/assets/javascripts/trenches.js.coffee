# coffee script yeah!

jQuery ->

  $(document).bind 'end.pjax', ->
    title = $.trim( $(document).find('title').text() )
    $('div#title h1').html(title) if title
    #subnav = $('[data-pjax-container]').find('[data-subnav-container]').remove().html()
    #$('div#header').find('[data-subnav-container]').html subnav if subnav

  # sort backlog
  $('#sortable').sortable
    update: ->
      $.ajax
        type: 'post'
        data: $('#sortable').sortable('serialize', attribute: 'id')
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

  # sortable lists 
  sortable_settings = 
    items: "li:not(.not-sortable)"
    connectWith: ".connectedSortable"
  $(".sortable").sortable(sortable_settings).disableSelection()

  $(".sortable").sortable
    update: (event, ui) ->
      $.ajax
        type: 'post'
        data: $(@).sortable('serialize', attribute: 'id')
        dataType: 'script'
        context: @ #make this the context so that we can access it in the on complete function
        complete:(request) ->
          #todo: show if request has error
          $(@).effect('highlight')
        url: $(@).attr('data-url')

