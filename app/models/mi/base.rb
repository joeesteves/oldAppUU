class Mi::Base < Mi
  attr_reader :entorno, :escritorio

  def after_initialize
    load_mi(%w(entorno escritorio))
  end

private
  def load_mi(dependencias)
    dependencias.each do |dep|
      klass = ('Mi::' + dep.capitalize).constantize
      instance_variable_set('@'+dep, klass.new(@usuario))
    end
  end

end
