require 'rails_helper'

RSpec.describe Mi::Escritorio, type: :model do
  it do
    @escritorio = described_class.new(double())
    expect(@escritorio).to respond_to(:principal)
    expect(@escritorio).to respond_to(:corcho)
  end

end
