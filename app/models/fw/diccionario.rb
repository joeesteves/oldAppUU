require 'yaml'
class Fw::Diccionario
  attr_reader :underscored_klass
  FORMULARIO =  Dir[Rails.root.join("app","diccionarios","formularios", "*.yml")].inject({}) do |h, d|
    h.merge!(YAML.load(File.open(d)))
    h
  end

  FICHA =  Dir[Rails.root.join("app","diccionarios","fichas", "*.yml")].inject({}) do |h, d|
    h.merge!(YAML.load(File.open(d)))
    h
  end

  def initialize(underscored_klass)
    @underscored_klass = underscored_klass
  end

  def buscar(opt = {})
    opt = [ opt[:col], opt[:dicc] ]
    busqueda_especifica(*opt) || busqueda_general(*opt) || nil
  end

private

  def general(dicc)
    self.class.const_get(dicc.upcase)['general']
  end

  def especifico(dicc)
    self.class.const_get(dicc.upcase)[underscored_klass]
  end

  def busqueda_especifica(col, dicc)
    especifico(dicc)[col] if especifico(dicc)
  end

  def busqueda_general(col, dicc)
    general(dicc)[col]
  end

end
