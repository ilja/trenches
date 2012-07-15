module StoriesHelper
  def link_to_story_developer(story)
    unless story.assigned_to.blank?
      "(#{story.assigned_to.username})"
    end
  end

  def change_status_button(user, story)
    html = ""
    unless story.blank? or story.points.blank? or story.sprint_id.blank?
      if story.status == Status::OPEN
        html << link_to('Start', start_story_path(user, story.project, story), :class => "button", :rel => "start-story")
      end
      if story.status == Status::ACTIVE
        html << link_to('Done', finish_story_path(user, story.project, story), :class => "button", :rel => "finish-story")
      end
    end
    html.html_safe
  end

  def sort_buttons(params)
    filters = %w[open active done]
    active = Array(params).select { |value| filters.include?value.to_s.downcase }
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

  def all_or_own_toggle_buttons(params)
    filters = %w[all my]
    active = Array(params).select { |value| filters.include?value.to_s.downcase }

    html = ""
    names = {"all" => "All Stories", "my" => "My stories"}

    filters.each do |filter|
      text = names.fetch(filter, "")
      css = ""
      if active.include?(filter)
        url = {:show =>  active.delete_if { |item| item == filter}.join }
        css = "button active"
      else
        show = active.clone.delete_if { |item| item != filter}
        show << filter
        url = {:show => show.join}
        css = "button"
      end
      html << "<a href='?#{url.to_param}' class='#{css}'>#{text}</a>"
    end

    html.html_safe
  end

end
