require 'rails_helper'

RSpec.describe Fw::Traductor do
  let(:traductor) { described_class.new(described_class.to_s.underscore) }

  it 'responde a formulario' do
    expect(traductor).to respond_to(:formulario)
  end

  it 'responde a columnas con array' do
    allow(traductor).to receive(:columnas) { ['id', 'nombre', 'codigo', 'created_at']}
    formulario = traductor.formulario
    expect(formulario).to be_instance_of(Hash)
    formulario_vacio = formulario.select { |k| k =~ /_at|^id/ }
    expect(formulario_vacio).to be_empty()
  end

  it 'no esta en el diccionario' do
    allow(traductor).to receive(:columnas) { ['nombre','codigo'] }
    allow(traductor.diccionario).to receive(:buscar).with(col:'nombre', dicc: 'FORMULARIO') { nil }
    allow(traductor.diccionario).to receive(:buscar).with(col:'codigo', dicc: 'FORMULARIO') { {"label"=>"Codigo", "input"=>{"type"=>"text", "placeholder"=>"Escriba un codigo"}} }
    formulario = traductor.formulario
    expect(formulario['nombre']).to eq( nil )
    expect(formulario['codigo']).to be_instance_of(Hash)
    expect(formulario.size).to eq(1)

  end

end
