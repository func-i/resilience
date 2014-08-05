# TODO: create policies for CRUD actions
class BuildingBlocksController < ApplicationController
  respond_to :html

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @building_blocks = BuildingBlock.all
  end

  def show
    @building_block = BuildingBlock.find params[:id]
    respond_with @building_block
  end

  def new
    @building_block = BuildingBlock.new owner: current_user
    @building_block.attachments.build
    respond_with @building_block
  end

  def create
    @building_block = BuildingBlock.new premited_params

    if @building_block.save
      flash[:notice] = t 'controllers.building_blocks.create.notice'
    end

    respond_with @building_block
  end

  def edit
    @building_block = BuildingBlock.find params[:id]
    @building_block.attachments.build

    # TODO - extract clone logick
    unless current_user == @building_block.owner
      @building_block = @building_block.clone_with_new_owner(current_user)
      render :new
    else
      respond_with @building_block
    end
  end

  def update
    @building_block = BuildingBlock.find params[:id]

    if @building_block.update_attributes premited_params
      flash[:notice] = t 'controllers.building_blocks.update.notice'
    end

    respond_with @building_block
  end

  def destroy
    @building_block = BuildingBlock.find params[:id]

    if @building_block.destroy
      flash[:notice] = t 'controllers.building_blocks.update.notice'
    end

    respond_with @building_block
  end

  private

  def premited_params
    params[:building_block][:owner_id] = current_user.id
    params.require(:building_block).
      permit(:title, :owner_id, attachments_attributes: [:id, :file, :retained_file, :_destroy])
  end

end

