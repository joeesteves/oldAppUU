class Fw::Scope < ActiveRecord::Base
  scope :empresa, -> (klass, value) { where("gid like '%#{klass}%' and '#{value}' = ANY (incluido) or gid like '%#{klass}%' and publico = true and not '#{value}' = ANY (excluido)") }

end
