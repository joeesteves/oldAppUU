class Ba::Usuario < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :accesos
  has_many :notas, class_name: 'Fw::Nota'
  has_many :empresas, through: :accesos, class_name: 'Mi::Empresa', foreign_key: 'organizacion_id'
  store_accessor :memoria, :ultima_empresa

  def ultima_empresa
    super.to_i if super
  end

end
