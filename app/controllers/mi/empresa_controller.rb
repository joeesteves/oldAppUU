class Mi::EmpresaController < ApplicationController
  include Globales

  def index
    render json: @collection
  end

  def show
    render json: @item
  end

  def new
    render json: new_item, except: :id
  end

  #Cuando un usuario crea una empresa es su Empresa.. por eso el rol propietario
  def create
    @item.accesos.build({rol: En::Seguridad.rol_prop, usuario: current_ba_usuario})
    if @item.save
      @item.log(current_ba_usuario)
      render json: {options: {reload_empresas:true}}.as_json
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


  private
  def load_item
     @item = scoped.find(params[:id])
  end

  def build_item
    @item = sc::Resource.new(item_params)
  end

  def scoped
    sc::Resource.scoped(current_ba_usuario)
  end
end
