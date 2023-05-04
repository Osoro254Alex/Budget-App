class GroupsController < ApplicationController
  def index
    @user = current_user
    @groups = current_user.groups.all
  end

  def new
    @group = Group.new
  end

  def create
    @user = current_user
    @group = current_user.groups.new(group_params)
    if @group.save
      flash[:success] = 'Category created successfully.'
      redirect_to groups_path
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon.name, :author_id)
  end
end
