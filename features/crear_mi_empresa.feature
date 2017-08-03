Feature: 
  Como nuevo usuario
  tengo la opción de crear mi empresa
  y va a proceder a hacerlo
  Scenario: Crear mi empresa
    Given Soy un usuario loggeado
    When Pido crear mi empresa 
    Then Veo un formulario con los datos necesarios para dar de alta una nueva empresa
    Then Envio el formulario y la empresa queda asociada a mi usario como administrador