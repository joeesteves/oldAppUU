class Fw::TarjetasController < ApplicationController
  def create
    Ad::Secretaria.new(usuario: current_ba_usuario).to_desk(obj: {underscored_klass: params[:underscored_klass], item_id: params[:item_id]})
    head :no_content
    rescue
      render json: {errors: 'hubo un problema'}, status: 422
  end
end
