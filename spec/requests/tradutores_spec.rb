require 'rails_helper'

RSpec.describe Fw::TraductorController, type: :request do
  login_user
  describe "POST /traductor" do
    it 'should define user_signed_in?' do
      expect(@controller).to be_ba_usuario_signed_in
    end

    it "post traductor returns json object status 200  " do
      expect_any_instance_of(Fw::Traductor).to receive(:columnas) { ['nombre','estado']}
      post '/fw/traductor/form', {traductor: {location: 'ba/organizaciones'}}.as_json, @auth_headers
      expect(response).to have_http_status(200)
    end
  end
end
