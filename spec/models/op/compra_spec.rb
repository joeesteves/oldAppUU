require 'rails_helper'

RSpec.describe Mis::Operaciones::Compra, type: :model do
  before(:each) do
    @compra = mis_operaciones_compras(:compra)
    @item1 = op_items(:op_items_121)
    @compra.items = [@item1]
  end
  it 'hoy creo una compra con 1 producto' do
    expect(@compra).to be_valid
    expect(@compra.items.length).to eq(1)
    expect(@compra.save).to be_truthy
  end
  it 'hoy creo una compra con 2 productos' do
    @compra.bruto = 200
    @compra.impuesto = 42
    @compra.total = 242
    @compra.items << @item1
    expect(@compra.items.length).to eq(2)
    expect(@compra.save).to eq(true)
    expect(@compra.asiento_id).not_to eq(nil)
  end

  it 'devuelve las ultimas condiciones para caja' do
    Mis::Cuentas::Tarjeta.create(id:6, nombre: "Tarjeta", empresa_id:1)

    Mis::Cuentas::Caja.create(id:5, nombre: "Caja", empresa_id:1)
    @compra.condiciones = [op_condiciones(:caja)]
    expect(Mis::Operaciones::Compra.ultimas_condiciones(1).find {|i| i[:tipo] == 'caja' }.as_json).to eq({tipo: 'caja', nombre: 'Caja', cuenta_id: 5}.as_json)
  end
  it 'devuelve las condiciones para caja, tarjeta' do
    Mis::Cuentas::Caja.create(id:5, nombre: "Caja", empresa_id:1)
    Mis::Cuentas::Tarjeta.create(id:6, nombre: "Tarjeta", empresa_id:1)
    @compra.condiciones = [op_condiciones(:tarjeta)]
    expect(Mis::Operaciones::Compra.ultimas_condiciones(1).find {|i| i[:tipo] == 'tarjeta' }.as_json).to eq({tipo: 'tarjeta', nombre: 'Tarjeta', cuenta_id: 6}.as_json)
  end

  it 'devuelve las condiciones de posibles ' do
    Mis::Cuentas::Caja.create(id:5, nombre: "Caja", empresa_id:1)
    Mis::Cuentas::Tarjeta.create(id:6, nombre: "Tarjeta", empresa_id:1)
    expect(Mis::Operaciones::Compra.posibles_condiciones(1) ).to eq([
      {tipo: 'cta cte', cuentas: [id: 1, nombre: 'Proveedores']},
      {tipo: 'caja', cuentas: [id: 5, nombre: 'Caja']},
      {tipo: 'tarjeta', cuentas: [id: 6, nombre: 'Tarjeta']}].as_json)
  end


  it 'no guarda sin items' do
    validate_presence_of(:items)
  end

end
