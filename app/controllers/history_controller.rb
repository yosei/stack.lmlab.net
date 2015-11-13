class HistoryController < ApplicationController
    def show_diff
      data = Stack.find(params[:id])
      data1 = data.versions.last.reify
      text = Diffy::Diff.new(data1.problem, data.problem).to_s(:html_simple)
      if text == '<div class="diff"></div>'
        # render :text => '<div class="diff">' + data.solution + '</div><div class="diff">' + data.solution + '</div>'
        render :text => '<div class="diff" style="float:left;margin:10px;">' + data.solution + '</div><div class="diff" style="float:left;margin:10px;">' + data.solution + '</div>'
      else
        text2 = text.gsub('<ul>', '')
        text2 = text2.gsub('</ul>', '')
        text2 = text2.gsub(/<li class="del"(.+?)<\/li>/, '')
        text2 = text2.gsub('<li', '<div')
        text2 = text2.gsub('</li', '</div')
        text2 = text2.gsub('<del>', '')
        text2 = text2.gsub('</del>', '')
        text2 = text2.gsub('<ins>', '')
        text2 = text2.gsub('</ins>', '')

        text = text.gsub('<ul>', '')
        text = text.gsub('</ul>', '')
        text = text.gsub(/<li class="ins"(.+?)<\/li>/, '')
        text = text.gsub('<li', '<div')
        text = text.gsub('</li', '</div')
        text = text.gsub('<del>', '')
        text = text.gsub('</del>', '')
        text = text.gsub('<ins>', '')
        text = text.gsub('</ins>', '')
        text = "<div class='diffContainer'>#{text}#{text2}</div>"
        # スタイルが適用されないため、ここで追加
        text = text.gsub('<div class="diff">', '<div class="diff" style="float:left;margin:10px;">')
        text = text.gsub('class="del">', 'class="del" style="color:red;">')
        text = text.gsub('class="ins">', 'class="ins" style="color:blue;">')
        text += "<div><a class='btn btn-default' href='/stacks/#{params[:id]}'>戻る</a></div>"
        render :text => text, :layout => "application"
      end
    end
end
