Rails.application.routes.draw do
  mount_devise_token_auth_for 'Ba::Usuario', at: 'auth'
  get 'inicio/index'
  root 'inicio#index'

  resources :sesion, only: :index
  post 'sesion/cambiar_empresa'


  namespace :co do
    resources :cuentas
    resources :impuestos
  end

  namespace :op do
    resources :egresos
  end

  namespace :fw do
    resources :traductor do
      collection do
        post 'form'
        post 'ficha'
      end
    end
    resources :notas
    resources :tarjetas, only: :create
  end

  namespace :ba do
    resources :organizaciones
    resources :roles, only: [:index, :show]
  end

  namespace :mis do
    namespace :organizaciones do
      resources :clientes
      resources :proveedores

    end
    namespace :operaciones do
      resources :compras do
        collection do
          get 'ultimas_condiciones'
          get 'posibles_condiciones'
        end
      end
      resources :ventas
    end
    namespace :tarjetas do
      post 'archivar'
      post 'fijar'
      post 'postergar'
    end
    namespace :cuentas do
      %w(bancos tarjetas cajas ingresos egresos).each {|r| resources r.to_sym}
    end
  end

  namespace :mi do
    resources :empresa
    resources :escritorio, only: :index
    resources :corcho, only: :index
    resources :archivo, only: :index
    resources :perfil, only:  :index do
      collection do
        post 'update'
      end
    end
  end

  namespace :pr do
    %w(bienes servicios unidades ).each {|r| resources r.to_sym}
  end

  namespace :in do
    resources :depositos
  end


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
