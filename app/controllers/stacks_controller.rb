class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :show_picture, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :show_picture]

  require 'tempfile'

  # GET /stacks
  # GET /stacks.json
  def index
    @q = params[:q] || ""
    tags, keywords = parse_params(@q)
    res = Stack.search({title_cont_all: keywords,stacks_tags_name_eq_all: tags}).result
    logger.debug("***************")
    logger.debug(tags)
    logger.debug(keywords)
    logger.debug(res.to_sql)
    logger.debug("***************")
    @stacks = res.page(params[:page])
  end

  def home
    @user = current_user
  end

  # GET /stacks/1
  # GET /stacks/1.json
  def show
    @stack_show = Stack.find(params[:id])
    if @stack_show.updated_at < Date.current.prev_year
      flash.now[:alert] = 'この記事は最終更新日から1年以上が経過しています'
    end
  end

  def show_picture
    n = params[:n]
    if ["1","2","3"].include? n
      d = @stack["picture"+n]
      if d
        send_data d, :type => 'image/png', :disposition => "inline"
      else
        raise ActionController::RoutingError.new('Not found: picture'+n.to_s)
      end
    else
      raise ActionController::RoutingError.new('Invalid param n:'+n.to_s)
    end
  end

  def download
    @stacks_count = Stack.maximum('id')
    fname = 'download.txt'

    if(@stacks_count)
      begin
        io = Tempfile.new(fname)
        io.puts "Stacks"

        for count in 1..@stacks_count do
          begin
            @stack_txt = Stack.find(count)
          rescue
          else
            io.print "Id : "
            io.puts @stack_txt.id
            io.print "Title : "
            io.puts @stack_txt.title
            io.puts "Problem :"
            io.puts @stack_txt.problem
            io.puts "Solution :"
            io.puts @stack_txt.solution
            io.puts "Explanation :"
            io.puts @stack_txt.explanation
            io.print "url1 : "
            io.puts @stack_txt.url1
            io.print "url2 : "
            io.puts @stack_txt.url2
            io.print "url3 : "
            io.puts @stack_txt.url3
            io.print "created_at : "
            io.puts @stack_txt.created_at
            io.print "updated_at : "
            io.puts @stack_txt.updated_at
            io.puts "----------------------------------------"
          end
        end

        io.rewind
        send_data(io.read, :filename => fname)
      ensure
        io.close
        io.unlink
      end
    else
      # stacksが0の場合
      redirect_to :back, status: '記事が存在しないため、ダウンロードできません。'
    end
  end

  # GET /stacks/new
  def new
    @stack = Stack.new
    @user = user_session
  end

  # GET /stacks/1/edit
  def edit
  end

  # POST /stacks
  # POST /stacks.json
  def create
    @stack = Stack.new(stack_params)

    respond_to do |format|
      if @stack.save
        format.html { redirect_to @stack, notice: 'Stack was successfully created.' }
        format.json { render :show, status: :created, location: @stack }
      else
        format.html { render :new }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stacks/1
  # PATCH/PUT /stacks/1.json
  def update
    respond_to do |format|
      if @stack.update(stack_params)
        format.html { redirect_to @stack, notice: 'Stack was successfully updated.' }
        format.json { render :show, status: :ok, location: @stack }
      else
        format.html { render :edit }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stacks/1
  # DELETE /stacks/1.json
  def destroy
    @stack.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Stack was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stack
      @stack = Stack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stack_params
      params.require(:stack).permit(:title, :problem, :solution, :explanation, :url1, :url2, :url3, :picture1, :picture2, :picture3)
    end

    def parse_params(q)
      tags = []
      keywords = []
      q.split(" ").each do |f|
        v = f.split(/[:,]/)
        if v.length == 1
          keywords += [v[0]]
        elsif v[0] == "tag"
          tags += v[1,v.length-1]
        end
      end
      return [tags,keywords]
    end
end
