class Mi::Empresa < Ba::Organizacion
  has_many :relaciones, class_name: 'Ba::Relacion'
  has_many :organizaciones, through: :relaciones
  has_many :rel_cli,  -> { where(tipo: [0, 3]) }, class_name: 'Ba::Relacion'
  has_many :clientes, through: :rel_cli
  has_many :rel_pro,  -> { where(tipo: [1, 3]) }, class_name: 'Ba::Relacion'
  has_many :proveedores, through: :rel_pro
  has_many :accesos, dependent: :destroy, class_name: 'Ba::Acceso'
  has_many :usuarios, through: :accesos
  validates :cat_fiscal, presence: {message: '- Debe indicar la categoría fiscal'}
  scope :scoped, -> (uid) { where('id in (?)', Ba::Acceso.where(usuario_id: uid).collect(&:empresa_id) )}
  def nuevo_cliente
    #si existe en organizacion lo asocia si no lo crea y luego asocia
  end

  def nuevo_proveedor
    #si existe en organizacion lo asocia si no lo crea y luego asocia
  end

  def log(usuario)
    usuario.update({ultima_empresa: self.id})
  end

end
