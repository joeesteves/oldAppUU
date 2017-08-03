class Ba::Organizacion < ActiveRecord::Base
  PARAMS = [:nombre, :cat_fiscal]
  include Standard::ValidationsAbm
  scope :ajenas, -> (uid) { where('id not in (?)', Ba::Acceso.where(usuario_id: uid).collect(&:empresa_id) ) }
end

Ba::Organizacion::CFISCALES = {
  monotributista: 'mona',
  reponsable_inscripto: 'repo',
  exento: 'exeo',
  exterior: 'extr'
}
