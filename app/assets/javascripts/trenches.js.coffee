# coffee script yeah!

$ ->
  $('.expand').click ->
    storybody = $(this).parents("li.story").children('.storybody')
    if storybody.css('display') == 'none'
      $(this).find("img").attr src:"/assets/close.png"
    else
      $(this).find("img").attr src:"/assets/open.png"

    storybody.toggle('fast')