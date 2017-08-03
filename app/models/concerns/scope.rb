module Scope
end

module Scope::Empresa
  extend ActiveSupport::Concern
  included do
    scope :scoped, -> (empresa_id) { where(empresa_id: empresa_id) }
  end
end

module Scope::Comun
  extend ActiveSupport::Concern
  included do
    attr_accessor :empresa_id, :publico
    scope :scoped, -> (empresa_id) { where('id in (?)', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id) )}
    after_save :globalize
  end

  def globalize
    global_obj = Fw::Scope.find_or_create_by(gid: self.to_gid.to_s)
    global_obj.objeto_id = self.id
    global_obj.incluido  |= [empresa_id]
    global_obj.publico = publico || false
    global_obj.save
  end
end

module Scope::Usuario
  extend ActiveSupport::Concern
  included do
    attr_accessor :empresa_id
    scope :scoped, -> (empresa_id) { where('id in (?)', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id) )}
    validates :empresa_id, presence: true
    after_save :globalize
  end

  def globalize
    global_obj = Fw::Scope.find_or_create_by(gid: self.to_gid.to_s)
    global_obj.objeto_id = self.id
    global_obj.incluido  |= [empresa_id]
    global_obj.save
  end
end
