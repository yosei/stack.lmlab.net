module StacksHelper
  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

  def tags(stack)
    ts = []
    stack.stacks_tags.each do |t|
      ts += [link_to(t.name, root_path(q: "tag:"+t.name), class: "label label-default")]
    end
    html = ts.join(" ")
    return html.html_safe
  end

  def markdown(text)
    @@markdown.render(text).html_safe
  end
end
