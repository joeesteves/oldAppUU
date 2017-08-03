module Standard
end

module Standard::ValidationsAbm
  extend ActiveSupport::Concern
  included do
    validates :nombre, presence: true, uniqueness: true
  end
end
module Standard::ValidationsAbmCoded
  extend ActiveSupport::Concern
  included do
    validates :codigo, presence: true, uniqueness: true
    validates :nombre, presence: true, uniqueness: true
  end
end

module Standard::Tarjeteable
  extend ActiveSupport::Concern

  def tarjetizar args
    sec = Ad::Secretaria.new(args).to_desk obj: self
  end

  def estado_tarjeta
    sec = Ad::Secretaria.new.check self
  end
end

module Standard::Taggeable
  extend ActiveSupport::Concern

  def tag(value, column = 'general')
    tag = Fw::Tag.find_or_create_by(gid: self.to_global_id.to_s)
    tags = tag.send(column)
    tags |= [value.to_s]
    tag.send(column+'=', tags  )
    tag.objeto_id = self.id
    tag.save
  end

  module ClassMethods
    def tagged(value, column = 'general')
      find(Fw::Tag.send(column, self.to_s, value).collect(&:objeto_id))
    end
  end
end
