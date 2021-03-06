Rails.application.routes.draw do
  get 'tools/check_caimpaign'
  post 'tools/check_caimpaign'
  get 'download_test_caimpaign', to: 'tools#download_test_caimpaign', as: :download_test_caimpaign
  get 'export', to: 'tools#export', as: :test_caimpaign_export
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  #1point1 api
  get 'api/sync_master' => 'api#sync_master'
  get 'api/pull_phone_numbers' => 'api#pull_phone_numbers'

  #1point1 API
  #jsonapi_resources :phones
  namespace :api do
    namespace :v1 do
      get 'phones' => 'phones#index'
      post 'members' => 'members#create'
    end
  end
end
