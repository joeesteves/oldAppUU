class Co::Asiento < ActiveRecord::Base
  validates_presence_of :fecha, :moneda_id, :cotizacion, :empresa_id, :esgenerado
	validates :items, presence: {message: 'dos items minimo'}, length: { minimum: 2, message: 'dos items minimo' }
  validate :balanceado?
  has_many :items, dependent: :destroy
  belongs_to :moneda

  validate do
    errors.delete(:items)
    items.each_with_index do |item, index|
      next if item.valid?
      item_errors = item.errors.full_messages
      errors[:base] << "Item #{index}: #{item_errors.to_sentence}"
    end
  end

def balanceado?
  sum = items.inject(0) {|sum,i| sum += (i.debe - i.haber); sum}
  errors.add(:base, "El asiento no balancea por una diferencia de #{sum}") if  sum != 0
end

end
