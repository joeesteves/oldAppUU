# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Usuario
@usuario = Ba::Usuario.create({uid: 'ajesteves@gmail.com', email:'ajesteves@gmail.com',provider: 'email', password: 'xxxxyyyy', password_confirmation: 'xxxxyyyy', confirmed_at: Date.today, memoria: {empresa: 1 } })

#Roles
Ba::Rol.create([{nombre: 'prop', descripcion: 'propietario es la max autoridad, puede borrar la empresa'},{nombre: 'admin', descripcion: 'idem propiestario pero no puede borrar la empresa ni agregar administradores'}, {nombre: 'colab', descripcion: 'puede operar en la empresa, pero no tiene acceso a los abm'}])

#Notas del sistema
Fw::Nota.create([
{titulo: 'Actualiza tu perfil', contenido: '<a href="#/mi/perfil" class="btn btn-success">Mi Perfil</a>'},
{titulo: 'Crear Empresa', contenido: '<a href="#/mi/empresa/new" class="btn btn-success">Crear mi empresa</a>'},
{titulo: 'Agregue sus bancos', contenido: '<a href="#/mi/perfil" class="btn btn-success">Agregar Bancos</a>'},
{titulo: 'Revise los rubros', contenido: 'Quiere agregar o quitar alguno ? <br> <a href="#/mi/perfil" class="btn btn-success">Chequear rubros</a>'},
{titulo: 'Invitaciones pendientes', contenido: 'Invitaciones'},
{titulo: 'Solicitar Invitaciones', contenido: 'Solicitar'}
	])

#Taggea las notas como del sistema
Fw::Nota.all.each {|nota| nota.tag('recepcion', 'sistema') }


Co::Cuenta.create [
  {nombre: 'Proveedores', tipo: Co::Cuenta::TIPOS[:acreedores]},
  {nombre: 'Clientes', tipo: Co::Cuenta::TIPOS[:deudores]},
  {nombre: 'Credito Fiscal', tipo: Co::Cuenta::TIPOS[:activo]},
  {nombre: 'Debito Fiscal', tipo: Co::Cuenta::TIPOS[:pasivo]},
]
Mis::Cuentas::Caja.create(nombre: 'Caja')
Mis::Cuentas::Tarjeta.create(nombre: 'Tarjeta')


Co::Cuenta.all.each {|cta| cta.tag('cuentas', 'sistema') }

[{nombre: 'IVA 21', alicuota: 21,},
{nombre: 'IVA 10.5', alicuota: 10.5},].each do |imp|
  Co::Impuesto.create imp.merge({c_cta_id: Co::Cuenta::PRINCIPALES[:c_fiscal], d_cta_id: Co::Cuenta::PRINCIPALES[:d_fiscal], publico: true })
end
Co::Impuesto.create nombre: 'EXENTO', alicuota:0, publico: true

Co::Impuesto.all.each {|imp| imp.tag('impuestos', 'sistema') }
