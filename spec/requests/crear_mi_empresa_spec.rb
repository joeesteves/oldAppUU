require 'rails_helper'

RSpec.describe Mi::EmpresaController, type: :request do
  login_user
  describe "crear empresa con usuario" do
    it 'crea empresa con current_ba_usuario como prop' do
      allow(En::Seguridad).to receive(:rol_prop) { ba_roles(:prop) }
      post '/mi/empresa', {empresa: {nombre: "nueva ong", cat_fiscal: 'repo'}}.as_json, @auth_headers
      expect(response).to have_http_status(200)
    end
  end
end
