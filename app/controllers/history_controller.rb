class HistoryController < ApplicationController
  def index
      res = Stack.find(params[:id])
      res_v = res.versions
      count = res_v.index
      res_v.unshift(res.title)
      @history = res_v.page(params[:page])
  end

  def show_diff
    data = Stack.find(params[:id])
    data1 = data.versions.last.reify
    text = Diffy::Diff.new(data1.problem, data.problem).to_s(:html_simple)
    if text == '<div class="diff"></div>'
      # render :text => '<div class="diff">' + data.solution + '</div><div class="diff">' + data.solution + '</div>'
      render :text => '<div class="diff" style="float:left;margin:10px;">' + data.solution + '</div><div class="diff" style="float:left;margin:10px;">' + data.solution + '</div>'
    else
      text = text.gsub('<ul>', '<table>')
      text = text.gsub('</ul>', '</table>')
      text = text.gsub('<li', '<tr><td>　</td><td')
      text = text.gsub('</li>', '</td></tr>')
      text = text.gsub('<tr><td>　</td><td class="del">', '<tr class="del"><td>-</td><td>')
      text = text.gsub('<tr><td>　</td><td class="ins">', '<tr class="ins"><td>+</td><td>')
      text = text.gsub('<del>', '')
      text = text.gsub('</del>', '')
      text = text.gsub('<ins>', '')
      text = text.gsub('</ins>', '')
      render :text => text, :layout => "application"
    end
  end
end
