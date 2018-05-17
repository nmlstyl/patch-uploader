class PatchesController < ApplicationController

  def index
    @patches = Patch.all
  end

  def show
    @user = current_patch_user
    @patch = Patch.find(params[:id])
  end

  def new
    @user = current_patch_user
    @patch = Patch.new
  end

  def create
    binding.pry
    @user = current_patch_user
    @patch = Patch.new(patch_params)
    if @user.patches << @patch
      if params[:patch][:category]['name'] != ''
        @category = Category.create(name: params[:patch][:category]['name'])
        @category.patches << @patch
      end
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = current_patch_user
    @patch = Patch.find(params[:id])
  end

  def update
    @user = current_patch_user
    @patch = Patch.find(params[:id])
    if @patch.update(patch_params)
      if params[:patch][:category]['name'] != ''
        @category = Category.create(name: params[:patch][:category]['name'])
        @category.patches << @patch
      end
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    user = current_patch_user
    patch = Patch.find(params[:id])
    patch.destroy
    redirect_to user_path(user)
  end

  private

  def current_patch_user
    User.find(params[:user_id])
  end

  def patch_params
    params.require(:patch).permit(:file, :name, :description, :game, :original, :category['name'], :category_ids => [])
  end
end
