require 'rails_helper'

RSpec.describe Mis::Organizaciones::ClientesController, type: :request do
  describe "listar organizaciones" do
    login_user
    it 'lista las organizaciones de scope de empresa 1' do
      get '/mis/organizaciones/clientes', @auth_headers
      # puts parse_json(response)
      expect(response).to have_http_status(200)
    end
  end
end
