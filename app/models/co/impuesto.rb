class Co::Impuesto < ActiveRecord::Base
  include Standard::ValidationsAbm, Scope::Comun,  Standard::Taggeable
  belongs_to :c_cta, class_name: 'Co::Cuenta'
  belongs_to :d_cta, class_name: 'Co::Cuenta'  
  before_save :set_coef

  private
    def set_coef
      self.coef = alicuota / 100
    end

end
