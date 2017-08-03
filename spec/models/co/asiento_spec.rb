require 'rails_helper'

RSpec.describe Co::Asiento, type: :model do
  it 'crear un asiento simple asiento' do
    asiento = described_class.new fecha: Date.today, moneda_id: 1, cotizacion: 1, empresa_id: 1, esgenerado: true
    asiento.items.build cuenta_id: 1, debe: 100
    asiento.items.build cuenta_id: 2, haber: 100
    expect(asiento.save!).to eq(true)
  end
  it 'no valida asiento desbalanceado' do
    asiento = described_class.new fecha: Date.today, moneda_id: 1, cotizacion: 1, empresa_id: 1, esgenerado: true
    asiento.items.build(cuenta_id: 1, debe: 101)
    asiento.items.build(cuenta_id: 2, haber: 100)
    expect(asiento.save()).to eq(false)
  end
end
