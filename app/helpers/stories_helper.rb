module StoriesHelper
  def link_to_story_developer(story)
    unless story.assigned_to.blank?
      "(#{story.assigned_to.name})"
    end
  end

  def change_status_button(story)
    html = ""
    unless story.blank? or story.points.blank? or story.sprint_id.blank?
      if story.status == "open"
        html << link_to('Start', start_story_path(story.project, story), :class => "button")
      end
      if story.status == "active"
        html << link_to('Done', finish_story_path(story.project, story), :class => "button")
      end
    end
    html.html_safe
  end
end
