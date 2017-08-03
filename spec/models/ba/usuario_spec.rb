require 'rails_helper'

RSpec.describe Ba::Usuario, type: :model do
  let(:usuario) { ba_usuarios(:usuario) }
  let(:empresa) { mi_empresas(:empresa) }
  it { expect(usuario).to be_instance_of(described_class) }
  it { expect(usuario).to respond_to(:empresas) }
  it { expect(usuario).to respond_to(:accesos) }
  it 'crea acceso con empresa desde usuario' do
    expect(usuario.accesos.create(rol: ba_roles(:admin), empresa: empresa)).to be_instance_of(Ba::Acceso)
  end
end
