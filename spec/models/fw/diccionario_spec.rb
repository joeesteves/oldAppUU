require 'rails_helper'

RSpec.describe Fw::Diccionario do
  let(:diccionario) { described_class.new(described_class.to_s.underscore) }
  before(:each) do
    stub_const("Fw::Diccionario::FORMULARIO", {
      general: {nombre: 'campo_general', codigo: 'codigo_general'},
      especifica: {nombre: 'campo_especifico'} }.as_json  )
    allow(diccionario).to receive(:underscored_klass) { 'especifica' }
  end

  it do
    expect(diccionario).to respond_to(:buscar)
  end

  it 'usa diccionario especifico si esta descripto' do
    expect(diccionario.buscar(col: 'nombre', dicc: 'FORMULARIO')).to eq('campo_especifico')
  end

  it 'usa diccionario general si no esta la palabra en el especifico' do
    expect(diccionario.buscar(col: 'codigo', dicc: 'FORMULARIO')).to eq('codigo_general')
  end

  it 'devuelve nil si no esta la palabra en ninguno de los dos' do
    expect(diccionario.buscar(col: 'no disponible', dicc: 'FORMULARIO')).to eq(nil)
  end

  it 'usa diccionario general si no esta el especfico' do
    allow(diccionario).to receive(:underscored_klass) { 'no_detallada' }
    expect(diccionario.buscar(col: 'nombre', dicc: 'FORMULARIO')).to eq('campo_general')
  end

end
