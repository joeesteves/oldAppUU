class En::Seguridad

  class << self
    %w(prop admin colab).each do |rol|
      define_method 'rol_' + rol do
        Ba::Rol.find_by(nombre: rol)
      end
    end
  end

end
