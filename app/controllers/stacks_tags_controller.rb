class StacksTagsController < ApplicationController
  before_action :set_stacks_tag, only: [:show, :edit, :update, :destroy]

  # GET /stacks_tags
  # GET /stacks_tags.json
  def index
    @stacks_tags = StacksTag.all
  end

  # GET /stacks_tags/1
  # GET /stacks_tags/1.json
  def show
  end

  # GET /stacks_tags/new
  def new
    @stacks_tag = StacksTag.new
  end

  # GET /stacks_tags/1/edit
  def edit
  end

  # POST /stacks_tags
  # POST /stacks_tags.json
  def create
    @stacks_tag = StacksTag.new(stacks_tag_params)

    respond_to do |format|
      if @stacks_tag.save
        format.html { redirect_to @stacks_tag, notice: 'Stacks tag was successfully created.' }
        format.json { render :show, status: :created, location: @stacks_tag }
      else
        format.html { render :new }
        format.json { render json: @stacks_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stacks_tags/1
  # PATCH/PUT /stacks_tags/1.json
  def update
    respond_to do |format|
      if @stacks_tag.update(stacks_tag_params)
        format.html { redirect_to @stacks_tag, notice: 'Stacks tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @stacks_tag }
      else
        format.html { render :edit }
        format.json { render json: @stacks_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stacks_tags/1
  # DELETE /stacks_tags/1.json
  def destroy
    @stacks_tag.destroy
    respond_to do |format|
      format.html { redirect_to stacks_tags_url, notice: 'Stacks tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stacks_tag
      @stacks_tag = StacksTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stacks_tag_params
      params.require(:stacks_tag).permit(:stack_id, :name)
    end
end
