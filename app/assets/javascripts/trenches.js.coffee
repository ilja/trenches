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

	$('#sortable').disableSelection

	$('div.expand').live 'click', ->
		storybody = $(this).parents("li.story").children('.storybody')
		if storybody.css('display') == 'none'
			$(this).find("img").attr src:"/assets/close.png"
		else
			$(this).find("img").attr src:"/assets/open.png"
		storybody.toggle('fast')