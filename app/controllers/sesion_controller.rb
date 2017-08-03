class SesionController < ApplicationController
  def index
    @sesion_actual = {}
    @sesion_actual[:empresa] = Ba::Organizacion.find(session[:empresa]) if session[:empresa]
    render json: @sesion_actual
  end

  def cambiar_empresa
    current_ba_usuario.update ultima_empresa: params[:id]
    session[:empresa] = params[:id]
    @sesion_actual = {}
    @sesion_actual[:empresa] = Ba::Organizacion.find(session[:empresa])
    render json: @sesion_actual
  rescue
    render json: {error: 'no se pudo cambiar la empresa'}, status: 422
  end
end
