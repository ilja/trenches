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

  def sort_button(params)
    filters = %w[open active done]
    active = params.to_a.select { |value| filters.include?value.to_s }
    html = ""
    names = {"open" => "Open", "active" => "In progress", "done" => "Done"}

    filters.each do |filter|
      text = names.fetch(filter, "")
      css = ""
      if active.include?(filter)
        url = {:show => active.clone.delete_if { |item| item == filter} }
        css = "button active"
      else
        url = {:show => active.clone << filter}
        css = "button"
      end
      html << "<a href='?#{url.to_param}' class='#{css}'>#{text}</a>"
    end

    html.html_safe
  end

end
