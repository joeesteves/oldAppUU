require 'rails_helper'

RSpec.describe Mis::Operaciones::ComprasController, type: :request do
  login_user
  describe "listar organizaciones" do
    it 'crea una compra mediante post con un producto' do
      compra = {
        fecha: Date.today,
        organizacion_id: 10,
        bruto: 100.00,
        impuesto: 21.00,
        total: 121,
        obs: 'factura de computible',
        items: [{producto_id: pr_servicios(:servicio).id  , precio: 100.00, cantidad:1, importe: 100, obs: 'todo ok' }] }
        post '/mis/operaciones/compras', {compra: compra}.as_json, @auth_headers
        expect(response).to have_http_status(204)
      end
      it 'inicia una compra con un item' do
        get '/mis/operaciones/compras/new', @auth_headers
        respuesta = parse_json(response)
        expect(respuesta[:items]).not_to be_nil
      end
    it 'lista las comptas' do
      compra = {
        fecha: Date.today,
        organizacion_id: 1,
        bruto: 100.00,
        impuesto: 21.00,
        total: 121,
        obs: 'factura de computible',
        items: [{producto_id: pr_servicios(:servicio).id  , precio: 100.00, cantidad:1, importe: 100, obs: 'todo ok' }] }
        post '/mis/operaciones/compras', {compra: compra}.as_json, @auth_headers

        get '/mis/operaciones/compras', @auth_headers
        respuesta = pj
        # puts respuesta

        expect(response).to have_http_status(200)
      end
  end
end
