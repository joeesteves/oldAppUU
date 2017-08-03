class Co::Item < ActiveRecord::Base
  validates :cuenta_id, presence: {message: 'ausente'} 
  validate :integridad
  belongs_to :asiento

private
  def integridad
    debe_o_haber_en_cero?
    debe_o_haber_diferente_a_cero?
  end

  def debe_o_haber_en_cero?
    errors.add(:base, 'debe != 0 & haber != 0') unless debe == 0 || haber == 0
  end
  def debe_o_haber_diferente_a_cero?
    errors.add(:base, 'debe = haber = 0') if debe == haber && debe == 0
  end
end
