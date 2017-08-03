class Mis::TarjetasController < ApplicationController
  def archivar
    Ad::Secretaria.new.archivar(params[:id])
    head :no_content
  end

  def postergar
    Ad::Secretaria.new.postergar(params[:id])
    head :no_content
  end

  def fijar
    Ad::Secretaria.new.fijar(params[:id])
    head :no_content
  end
end
