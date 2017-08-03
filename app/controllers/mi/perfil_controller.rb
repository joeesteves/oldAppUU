class Mi::PerfilController < ApplicationController
  before_action :load_item, only: [:index, :update, :destroy]

  def index
    render json: @item
  end

  def update
    if @item.update(item_params)
      head :no_content
    else
      render json: {errors: @item.errors.full_messages}, status: 422
    end
  end

  def destroy
    if @item.destroy
      head :no_content
    else
      render json: {errors: @item.errors.full_messages}, status: 422
    end
  end

private

  def load_item
     @item = current_ba_usuario
  end

  def item_params
    params.require(:perfil).permit(:id, :nickname)
  end

end
