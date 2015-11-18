class HistoryController < ApplicationController
  def index
    @stack = Stack.find(params[:id])
    stack_version = @stack.versions
    @count = stack_version.length
    array = []
    array << @stack
    stack_version.reverse.each do |sv|
      array << sv.reify
    end
    #配列の最後の要素はいらないため削除
    array.pop
    @history = Kaminari.paginate_array(array).page(params[:page])
  end

  def diff
    @origin = Stack.find(params[:id])
    num = @origin.versions.length - 1
    if params[:num].to_i == 0
      before_data = @origin.versions.last.reify
      after_data = @origin
    else
      after_data = @origin.versions[0 - params[:num].to_i].reify
      before_data = after_data.previous_version
    end

    unless params[:num].to_i == num
      #title
      text = Diffy::Diff.new(before_data.title, after_data.title).to_s(:html_simple)
      @title = diff_text(text, after_data.title, "text")
      #problem
      text = Diffy::Diff.new(before_data.problem, after_data.problem).to_s(:html_simple)
      @problem = diff_text(text, after_data.problem, "text")
      #solution
      text = Diffy::Diff.new(before_data.solution, after_data.solution).to_s(:html_simple)
      @solution = diff_text(text, after_data.solution, "text")
      #explanation
      text = Diffy::Diff.new(before_data.explanation, after_data.explanation).to_s(:html_simple)
      @explanation = diff_text(text, after_data.explanation, "text")
      #url
      text = Diffy::Diff.new(before_data.url1, after_data.url1).to_s(:html_simple)
      @url1 = diff_text(text, after_data.url1, "url").html_safe
      text = Diffy::Diff.new(before_data.url2, after_data.url2).to_s(:html_simple)
      @url2 = diff_text(text, after_data.url2, "url").html_safe
      text = Diffy::Diff.new(before_data.url3, after_data.url3).to_s(:html_simple)
      @url3 = diff_text(text, after_data.url3, "url").html_safe
      #picture
      @picture1 = diff_pic(before_data.picture1, after_data.picture1)
      @picture2 = diff_pic(before_data.picture2, after_data.picture2)
      @picture3 = diff_pic(before_data.picture3, after_data.picture3)

    else
      #title
      text = Diffy::Diff.new("", after_data.title).to_s(:html_simple)
      @title = diff_text(text, after_data.title, "text")
      #problem
      text = Diffy::Diff.new("", after_data.problem).to_s(:html_simple)
      @problem = diff_text(text, after_data.problem, "text")
      #solution
      text = Diffy::Diff.new("", after_data.solution).to_s(:html_simple)
      @solution = diff_text(text, after_data.solution, "text")
      #explanation
      text = Diffy::Diff.new("", after_data.explanation).to_s(:html_simple)
      @explanation = diff_text(text, after_data.explanation, "text")
      #url
      text = Diffy::Diff.new("", after_data.url1).to_s(:html_simple)
      @url1 = diff_text(text, after_data.url1, "url")
      text = Diffy::Diff.new("", after_data.url2).to_s(:html_simple)
      @url2 = diff_text(text, after_data.url2, "url")
      text = Diffy::Diff.new("", after_data.url3).to_s(:html_simple)
      @url3 = diff_text(text, after_data.url3, "url")
      #picture
      @picture1 = diff_pic("", after_data.picture1).html_safe
      @picture2 = diff_pic("", after_data.picture2).html_safe
      @picture3 = diff_pic("", after_data.picture3).html_safe
    end
  end

  def diff_text(text, data, flug)
    if text == '<div class="diff"></div>'
      case flug
      when "text" then
        text = data.gsub('<', '&lt;')
        text = text.gsub('/', '&frasl;')
        text = text.gsub('>', '&gt;')
        text = text.gsub("\n", '<br>')
        text = "<div class='diff'>#{text}</div>"
      when "url" then
        text = "<div class='diff'>#{data}</div>"
      end
    else
      # text = text.gsub('<ul>', '<table>')
      # text = text.gsub('</ul>', '</table>')
      # text = text.gsub('<li', '<tr><td>　</td><td')
      # text = text.gsub('</li>', '</td></tr>')
      # text = text.gsub('<tr><td>　</td><td class="del">', '<tr class="del"><td>-</td><td>')
      # text = text.gsub('<tr><td>　</td><td class="ins">', '<tr class="ins"><td>+</td><td>')
      # text = text.gsub('<del>', '')
      # text = text.gsub('</del>', '')
      # text = text.gsub('<ins>', '')
      # text = text.gsub('</ins>', '')

      text = text.gsub('<ul>', '')
      text = text.gsub('</ul>', '')
      text = text.gsub('<li', '<div')
      text = text.gsub('</li', '</div')
      text = text.gsub('<div class="del">', '<div class="del"><span>-</span><td>')
      text = text.gsub('<div class="ins">', '<div class="ins"><span>+</span><td>')
      text = text.gsub('<del>', '')
      text = text.gsub('</del>', '')
      text = text.gsub('<ins>', '')
      text = text.gsub('</ins>', '')
    end
    return text
  end

  def diff_pic(befor_pic, after_pic)
    text = ""
    if befor_pic != after_pic
      if befor_pic != nil
        text = "<div class='ins'>画像が変更されました。</div>"
      end
    end
    return text
  end
end
