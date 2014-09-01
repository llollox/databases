Rails.application.routes.draw do
  resources :users
  resources :user_sessions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # ********************************************************
  # PASSES
  # ********************************************************
  resources :passes do 
    resources :localities, shallow: true
  end
  get 'passes_map' => 'passes#map', :as => :passes_map

  # ********************************************************
  # MUNICIPALITIES
  # ********************************************************
  resources :regions, shallow: true do
    resources :provinces, shallow: true do
      resources :municipalities, shallow: true do
        get 'infobox' => 'municipalities#infobox', :as => :infobox
        resources :fractions, shallow: true
        # resources :caps, shallow: true
        # resources :pictures, shallow: true
      end
      # resources :pictures, shallow: true
    end
    # resources :pictures, shallow: true
  end
  get 'municipalities_map' => 'municipalities#map', :as => :municipalities_map

  # ********************************************************
  # MOTO
  # ********************************************************
  resources :brands, shallow: true do 
    resources :models, shallow: true do
      resources :bikes, shallow: true do
        resources :pictures, shallow: true
      end
    end
  end
  resources :categories

  
  # ********************************************************
  # GENERAL
  # ********************************************************
  get 'login' => 'user_sessions#new', :as => :login
  get 'logout' => 'user_sessions#destroy', :as => :logout

  # You can have the root of your site routed with "root"
  root 'static#index'

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
