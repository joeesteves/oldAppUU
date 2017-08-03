class Mi::EscritorioController < ApplicationController
  before_action :load_item, only: :show

  def index
    @su = En::Recepcion.new(current_ba_usuario)
    render json: @su.escritorio
  end

end
