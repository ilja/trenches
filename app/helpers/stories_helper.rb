module StoriesHelper
	def link_to_story_developer(story)		
		unless story.assigned_to.blank? 
			"(#{story.assigned_to.name})"
		end
	end
end
