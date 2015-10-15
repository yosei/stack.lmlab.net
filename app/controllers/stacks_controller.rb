class StacksController < ApplicationController
  before_action :set_stack, only: [:show, :show_picture, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :show_picture]

  # GET /stacks
  # GET /stacks.json
  def index
    @q = Stack.search(params[:q])
    @stacks = @q.result.page(params[:page])
  end

  def home
    @user = current_user
  end

  # GET /stacks/1
  # GET /stacks/1.json
  def show
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

  # GET /stacks/new
  def new
    @stack = Stack.new
  end

  # GET /stacks/1/edit
  def edit
  end

  # POST /stacks
  # POST /stacks.json
  def create
    @stack = Stack.new(stack_params)
    binding.pry

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
      format.html { redirect_to stacks_url, notice: 'Stack was successfully destroyed.' }
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
end
