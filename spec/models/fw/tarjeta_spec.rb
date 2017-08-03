require 'rails_helper'

RSpec.describe Fw::Tarjeta, type: :model do
  it do
    @tarjeta = Fw::Tarjeta.new
    expect(@tarjeta).to respond_to(:objeto_gid)
    expect(@tarjeta).to respond_to(:titulo)
    expect(@tarjeta).to respond_to(:contenido)
    expect(@tarjeta).to respond_to(:estado)
  end

end
