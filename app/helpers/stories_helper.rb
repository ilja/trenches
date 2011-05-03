module StoriesHelper
	def link_to_story_developer(story)		
		unless story.assigned_to.blank? 
			"(#{story.assigned_to.name})"
		end
	end

	def change_status_button(story)
	  html = ""
	  if story.points > StoryPoint::UNKNOWN
	    html << "| " unless story.status == "done"
		
		if story.status == "open"				
	      html << link_to('Start', start_story_path(story.project, story))
	    end
	    if story.status == "active"	    	
	      html << link_to('Done', finish_story_path(story.project, story))
	    end
	  end
	  html.html_safe
	end
end
