require 'rails_helper'

RSpec.describe En::Recepcion, type: :model do
  let(:usuario) {ba_usuarios(:usuario)}
  let(:recepcion) { described_class.new(usuario)}

  it 'recibe un nuevo usuario por primera vez' do
    allow(recepcion).to receive(:primera_vez?) { true }
    expect(recepcion).to receive(:prepara_escritorio)
    recepcion.check_in
  end

  it 'recibe un nuevo usuario por segunda (o más) vez (veces)' do
    allow(recepcion).to receive(:primera_vez?) {false}
    expect(recepcion).not_to receive(:prepara_escritorio)
    recepcion.check_in
  end

  it 'crea tarjetas una sola vez' do
    notas = Fw::Nota.create([{titulo: 'Crear Otra Empresa', contenido: 'zaraza'},
      {titulo: 'Ver Invitaciones', contenido: 'zaraza'}])
    notas.each { |nota| nota.tag('recepcion', 'sistema')  }


    @recepcion = described_class.new(usuario)
    tarjetas = Fw::Tarjeta.dirigidas_a(usuario.id).pendientes.count
    expect(tarjetas).to eq(2)
    @recepcion.check_in
    tarjetas2 = Fw::Tarjeta.dirigidas_a(usuario.id).pendientes.count
    expect(tarjetas2).to eq(tarjetas)
    expect(tarjetas2).to eq(2)
  end
end
