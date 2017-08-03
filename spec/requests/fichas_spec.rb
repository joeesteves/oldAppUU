require 'rails_helper'

RSpec.describe Fw::TraductorController, type: :request do
  login_user
  describe "POST /traductor" do
    it "post traductor returns json object status 200  " do
      expect_any_instance_of(Fw::Traductor).to receive(:columnas) { ['comprobante','fecha', 'obs']}
      post '/fw/traductor/form', {traductor: {location: 'ba/organizaciones'}}.as_json, @auth_headers
      expect(response).to have_http_status(200)
    end
    it "post ficha returns json object with 3 key encabezado, contenido y footer and status 200" do
      post '/fw/traductor/ficha', {traductor: {location: 'mis/operaciones/compras'}}.as_json, @auth_headers
      data = pj
      expect(data[:encabezado]).not_to be(nil)
      expect(data[:contenido]).not_to be(nil)
      expect(data[:pie]).not_to be(nil)
      expect(response).to have_http_status(200)
    end

  end
end
