require 'rails_helper'

RSpec.describe Ad::Auxiliar, type: :model do
  before(:each) do
    @compra = mis_operaciones_compras(:compra)
    @item1 = op_items(:op_items_121)
    @compra.items = [@item1]
    @compra.empresa = mi_empresas(:empresa)
    @aux = described_class.new(operacion: @compra)
  end
  it do 'instancia un asiento'
    expect(@aux).to respond_to(:contabiliza)
  end

  it do 'crea un asiento y guarda el id en la op'
    @compra.save
    expect(@compra.asiento_id).not_to eq(nil)
  end

  it do 'update recrea el asiento'
    @compra.save
    id_1 = @compra.asiento_id
    expect(@compra.asiento_id).not_to eq(nil)
    @compra.update fecha: Date.tomorrow
    expect(@compra.asiento_id).not_to eq(id_1)
  end

  it do 'no guarda op al fallar la creacion del asiento'
    @compra.fecha = 'dato invalido'
    @compra.save
    expect(@compra.errors.full_messages.to_sentence).to match /fecha/i
  end
  it do 'compra con dos items guarda asiento'
    @compra.bruto = 200
    @compra.impuesto = 42
    @compra.total = 242
    @compra.items << @item1
    expect(@compra.items.length).to eq(2)
    expect(@compra.save).to eq(true)
    expect(@compra.asiento_id).not_to eq(nil)
  end
  it do 'compra con dos items ultimo item exento por edicion y guarda asiento'
    co_impuestos(:exento)
    @compra.bruto = 200
    @compra.impuesto = 21
    @compra.total = 221
    @compra.items << op_items(:op_item2)
    expect(@compra.items.length).to eq(2)
    expect(@compra.save).to eq(true)
    expect(@compra.asiento_id).not_to eq(nil)
    expect(@compra.detalle[:exento][:importe]).to eq(100)
  end
  it do 'compra con dos items ultimo item editado el iva'
    co_impuestos(:exento)
    @compra.bruto = 200
    @compra.impuesto = 21
    @compra.total = 221
    @compra.items << op_items(:op_item2)
    expect(@compra.items.length).to eq(2)
    expect(@compra.save).to eq(true)
    expect(@compra.asiento_id).not_to eq(nil)
    expect(@compra.detalle[:exento][:importe]).to eq(100)
  end


end

RSpec.describe 'condicion pago', type: :model do
  before(:each) do
    @compra = mis_operaciones_compras(:compra)
    @item1 = op_items(:op_items_121)
    @compra.items = [@item1]
    @compra.empresa = mi_empresas(:empresa)
    @aux = Ad::Auxiliar.new(operacion: @compra)
  end
  it do 'compra en 1 cuota'
    @compra.save
    items_en_cta_cte = @compra.asiento.items.where(cuenta_id: Mis::Operaciones::Compra::K[:cta_cte_default]).count
    expect(items_en_cta_cte).to eq(1)
  end
  it do 'compra en 2 cuotas'
    @compra.condiciones.first.update(forma: 'c2')
    @compra.fecha = '1/1/2016'.to_date
    @compra.save
    items_en_cta_cte = @compra.asiento.items.where(cuenta_id: Mis::Operaciones::Compra::K[:cta_cte_default])
    cantidad_items_en_cta_cte = items_en_cta_cte.count
    expect(cantidad_items_en_cta_cte).to eq(2)
    cuota_2 = items_en_cta_cte.last
    expect(cuota_2.venc).to eq('1/2/2016'.to_date)
  end
  it do 'redondeo en ultima cuota'
    @compra.condiciones.first.update(forma: 'c3')
    @compra.fecha = '1/1/2016'.to_date
    @compra.save
    items_en_cta_cte = @compra.asiento.items.where(cuenta_id: Mis::Operaciones::Compra::K[:cta_cte_default])
    expect(items_en_cta_cte.first.haber).to eq(40.33)
    expect(items_en_cta_cte.last.haber).to eq(40.34)
  end
  it do 'cuota 30, 60 y 90'
    @compra.condiciones.first.update(forma: '30, 60, 90')
    @compra.fecha = '1/1/2016'.to_date
    @compra.save
    items_en_cta_cte = @compra.asiento.items.where(cuenta_id: Mis::Operaciones::Compra::K[:cta_cte_default])
    expect(items_en_cta_cte.first.haber).to eq(40.33)
    expect(items_en_cta_cte.last.haber).to eq(40.34)
  end
  it do 'cuota irregular 30:40, 60:60'
    @compra.condiciones.first.update(forma: '30:40, 60:60')
    @compra.fecha = '1/1/2016'.to_date
    @compra.save
    items_en_cta_cte = @compra.asiento.items.where(cuenta_id: Mis::Operaciones::Compra::K[:cta_cte_default])
    expect(items_en_cta_cte.first.haber.to_f).to eq(48.40)
    expect(items_en_cta_cte.last.haber.to_f).to eq(72.60)
  end
  it do 'valida formato de condicion de pago'
    @compra.condiciones.build(forma: 'c30:40, 60:60')
    @compra.fecha = '1/1/2016'.to_date
    expect{@compra.save!}.to raise_error(ActiveRecord::RecordInvalid)
    expect(@compra.errors.messages[:condiciones].join(', ')).to match /revisar el formato/
    expect(@compra.save).to be(false)
  end
  it do 'cuota irregular arroja error si no suman 100'
    @compra.condiciones.build(forma: '30:40, 60:100')
    expect{@compra.save!}.to raise_error(ActiveRecord::RecordInvalid)
    expect(@compra.errors.messages[:condiciones].join(', ')).to match /la suma de los porcentajes debe ser 100/
    expect(@compra.save).to be(false)
  end
end
