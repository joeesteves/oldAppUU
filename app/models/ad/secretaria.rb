class Ad::Secretaria
  #Pueden instanciar a la secretaria con
  # hash dentro objetos tarjeteables para que me deje en el escritorio y el usuario (a quien va a estar dirigia la tarjeta)

  def initialize args = {}
    @usuario = args[:usuario]
  end

  def to_desk args
    set_tarjetable args[:obj]
    crear_tarjeta args[:anotacion] || {}
  end

  def update
    actualizar_tarjetas
  end

  def set_tarjetable obj
    if !obj.is_a? Hash
      @tarjeteable = obj
    elsif obj[:underscored_klass] && obj[:item_id]
      klass = obj[:underscored_klass].classify.constantize
      @tarjeteable = klass.find(obj[:item_id])
    end
  end

  def check obj
    hsh = {}
    # mejorar esto para que indique si tiene tarjeta en la que el usuario este involucrado
    if tarjeta = buscar_tarjeta(obj)
      hsh[:estado] = tarjeta.estado
      hsh[:titulo] = tarjeta.titulo
    end
    hsh
  end

  Fw::Tarjeta::ESTADOS.each do |k,v|
    define_method v[:accion] do |id|
      Fw::Tarjeta.find(id).update(estado: v[:id])
    end
  end


private
  def crear_tarjeta anotacion
    tarjeta = Fw::Tarjeta.new(dirigida_a: [@usuario.id])
    armar_tarjeta anotacion, tarjeta
  end

  def armar_tarjeta anotacion, tarjeta
    tarjeta.titulo = anotacion[:titulo] || (@tarjeteable.respond_to? :nombre) ? @tarjeteable.nombre : @tarjeteable.titulo || ''
    tarjeta.contenido = anotacion[:contenido] || (@tarjeteable.respond_to? :desc) ? @tarjeteable.desc : @tarjeteable.contenido || ''
    tarjeta.objeto_gid = @tarjeteable.to_global_id.to_s
    # tarjeta.titulo += 'Atencion: tarjeta duplicada' if gid_duplicado?(tarjeta.objeto_gid)
    tarjeta.save
  end

  def buscar_tarjeta
    tarjeta = Fw::Tarjeta.find_by(objeto_gid: @tarjeteable.to_global_id.to_s)
  end

  def buscar_tarjetas
    tarjetas = Fw::Tarjeta.where(objeto_gid: @tarjeteable.to_global_id.to_s)
  end

  def actualizar_tarjetas(anotacion = {})
    if tarjetas = buscar_tarjetas
      tarjetas.each do  |tarjeta|
        armar_tarjeta(anotacion, tarjeta)
      end
    end
  end

  def gid_duplicado?(gid)
    true if Fw::Tarjeta.find_by(objeto_gid: gid)
  end

end
