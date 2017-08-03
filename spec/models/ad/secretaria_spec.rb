require 'rails_helper'

RSpec.describe Ad::Secretaria, type: :model do
  before(:each) do
    @objeto = double()
    allow(@objeto).to receive(:titulo) { 'esta es una nota'}
    allow(@objeto).to receive(:contenido) { 'esta es el contenido de una nota'}
    allow(@objeto).to receive(:to_global_id.to_s) { 'esta es el contenido de una nota'}
    @sec = Ad::Secretaria.new usuario: ba_usuarios(:usuario)
  end
  it do
    allow(@sec).to receive(:crear_tarjeta) { @objeto }
    expect(@sec.to_desk obj: @objeto ).to eq @objeto
  end

  it do
    expect(@sec).to respond_to(:update)
  end
  it 'crea tarjeta con item del objeto y underscored_klass' do
    @nota = Fw::Nota.create titulo: 'bla bla', contenido: 'blu blu'
    rtado = @sec.to_desk(obj: {underscored_klass: 'fw/notas', item_id: @nota.id})
    expect(rtado).to be(true)


  end

end
