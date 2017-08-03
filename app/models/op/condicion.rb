class Op::Condicion < ActiveRecord::Base
  PARAMS = [:id, :cuenta_id, :forma, :importe]
  belongs_to :base
  validates :forma, format: { with: /(?:^\d{1,3}(?:(?:,|\s|y)+(?:\d{1,3})?)*$|^[a-z](?:\d{1,2})\s*$|^(?:\d+:\d+)(?:(?:,|\s)+(?:\d+:\d+))+$)/, message: "revisar el formato de la condición de pago" }
  validate :cuota_irreg_sume_100
  #valida que sume 100%
  def cuota_irreg_sume_100
    if forma.match(/^(?:\d+:\d+)(?:(?:,|\s)+(?:\d+:\d+))+$/)
      ctrl = 0
      forma.scan(/\d+:\d+/).flatten.each do |dia_porc|
        porc = dia_porc.split(':')[1].to_i
        ctrl += porc
      end
      errors[:forma] << 'la suma de los porcentajes debe ser 100' unless ctrl == 100
    end
  end
end
