module Globalizer
  extend ActiveSupport::Concern
  included do
    attributes *get_params
  end
  class_methods do
    def get_params
      serialized_klass = self.to_s.gsub('Serializer','').constantize
      # sacamos del array lo que no es Symbol... es decir los attributes anidados
      serialized_klass::PARAMS.select {|i| i if i.is_a? Symbol} | serialized_klass::ADICIONALES
    end
  end
end
