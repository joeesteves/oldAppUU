class Mis::Operaciones::PagosController < ApplicationController
  include Globales, Globales::Empresa

  def index
    render json: @collection
  end

  def show
    render json: @item
  end

  def new
    render json: new_item
  end

  def create
    if @item.save
      head :no_content
    else
      render json: {errors: @item.errors.full_messages}, status: 422
    end
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

  def posibles_condiciones
    render json: Mis::Operaciones::Pago.posibles_condiciones(@empresa_id)
  end

  def ultimas_condiciones
    render json:  Mis::Operaciones::Pago.ultimas_condiciones(@empresa_id)
  end

end

# private
#   def item_params
#     params[:compra][:items].each do |item|
#       item[:producto_id] = item[:producto][:id]
#       item.delete("producto")
#     end
#     super
#   end
