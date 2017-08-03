require 'rails_helper'

RSpec.describe Fw::Nota do
  let(:nota) { described_class.new() }

  it do
    expect(nota).to respond_to(:titulo)
    expect(nota).to respond_to(:contenido)
    expect(nota).to respond_to(:tarjetizar)
  end

end
