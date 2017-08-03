class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  before_action :authenticate_ba_usuario!, unless: :skip_auth?
  before_action :set_session_data

private

  def skip_auth?
    is_a?(InicioController) || devise_controller?
  end

  def set_session_data
    if ba_usuario_signed_in?
      session[:empresa] ||= current_ba_usuario.ultima_empresa # || log empresa
      @empresa_id = session[:empresa]
    else
      reset_session
    end
  end

end
