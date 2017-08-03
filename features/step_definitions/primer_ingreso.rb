Before do
  Fw::Nota.create([{titulo: 'Crear Empresa', contenido: 'zaraza'},
    {titulo: 'Ver Invitaciones', contenido: 'zaraza'}])
  @nota1 = Fw::Nota.first
  @nota2 = Fw::Nota.last
  @nota1.tag('recepcion', 'sistema')
  @nota2.tag('recepcion', 'sistema')
end

Given(/^Soy un nuevo usuario$/) do
  @usuario = create :usuario
end

When(/^Ingreso a la app sin tener ninguna empresa asociada$/) do

  @recepcion = En::Recepcion.new(@usuario)
  @escritorio = @recepcion.escritorio
  expect(@escritorio).to exist
  expect(@escritorio.count).to eq(2) # las dos notas taggeadas recepcion arriba
end

Then(/^Debo ver las invitaciones para asociarme a empresas ya existentes y confirmarlas$/) do
  # expect(@entorno).to respond_to(:invitaciones)
  # expect(@entorno.invitaciones).to be_kind_of(Array)
end

Then(/^O solitar a una empresa que me invite$/) do
  # expect(@entorno).to respond_to(:solicitar_invitacion)
end

Then(/^O crear una empresa como administrador$/) do
  @usuario.accesos.create(rol: build(:admin), empresa: create(:empresa))
  expect(@usuario.empresas.first).to be_instance_of(Mi::Empresa)
  @acceso = @usuario.accesos.first
  expect(@acceso.rol.nombre).to eq('administrador')
end
