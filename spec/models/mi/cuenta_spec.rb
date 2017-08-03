require 'rails_helper'

RSpec.describe Mi::Entorno do
  let(:cuenta) { Mi::Entorno.new({usuario: ba_usuarios(:usuario)}) }
  it do
    expect(cuenta).to respond_to(:invitaciones)
    expect(cuenta.invitaciones).to be_kind_of(Array)
  end
  it { expect(cuenta).to respond_to(:sin_empresa?) }
  it { expect(cuenta).to respond_to(:solicitar_invitacion)}
end
