require 'rails_helper'

RSpec.describe Co::Item, type: :model do
  it do 'no permite guardar item sin asiento_it'
    i = described_class.new cuenta_id: 1, debe: 100, haber: 100
    expect(i.save).to eq(false)
  end

  it do 'no permite guardar item si debe y haber son iguales '
    i = described_class.new asiento_id: 1, cuenta_id: 1, debe: 0, haber: 0
    expect(i.save).to eq(false)
  end

  it do 'no permite guardar item si ninguno es igual a 0'
    i = described_class.new asiento_id: 1, cuenta_id: 1, debe: 120, haber: 100
    expect(i.save).to eq(false)
  end
  it do 'permite guardar item con asiento_id'
    i = described_class.new asiento_id: 1, cuenta_id: 1, debe: 100, haber: 0.00
    expect(i.save).to eq(true)
  end

  it do 'permite guardar item si debe y haber son diferentes '
    i = described_class.new asiento_id: 1, cuenta_id: 1, debe: 100, haber: 0.00
    expect(i.save).to eq(true)
  end

  it do 'permite guardar item si alguno es igual a 0'
    i = described_class.new asiento_id: 1, cuenta_id: 1, debe: 0.00, haber: 100
    expect(i.save).to eq(true)
  end
end
