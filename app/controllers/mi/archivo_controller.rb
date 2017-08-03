class Mi::ArchivoController < ApplicationController
  before_action :load_item, only: :show

  def index
    @su = En::Recepcion.new(current_ba_usuario)
    render json: @su.archivo
  end

end
