class Fw::TraductorController < ApplicationController

  def form
    formulario = Fw::Traductor.new(traductor_params[:location], {empresa_id: @empresa_id}).formulario
    render json: formulario
    rescue Exception => e
    render json: {errors: {full_messages: [e.message]}}, status: 422
  end

  def ficha
    ficha = Fw::Traductor.new(traductor_params[:location]).ficha
    render json: ficha
  rescue Exception => e
    render json: {errors: {full_messages: [e.message]}}, status: 422
  end


private

  def traductor_params
    params.require(:traductor).permit(:location)
  end
end
