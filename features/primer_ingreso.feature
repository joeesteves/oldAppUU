Feature: 
  Como nuevo usuario
  me registro en appuu
  y tengo que pertencer a una empresa para operar 
  Scenario: Primer Ingreso a la app
    Given Soy un nuevo usuario
    When Ingreso a la app sin tener ninguna empresa asociada 
    Then Debo ver las invitaciones para asociarme a empresas ya existentes y confirmarlas
    Then O solitar a una empresa que me invite
    Then O crear una empresa como administrador