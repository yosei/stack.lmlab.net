module StacksHelper
  def tags(stack)
    html = ""
    stack.stacks_tags.each do |t|
      html += link_to t.name, "#", class: "label label-default"
    end
    return html.html_safe
  end
end
