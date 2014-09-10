Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #
  # Dashboard routes
  #
  get "dashboard/home"
  # navigation
  get "dashboard/first_page"
  get "dashboard/last_page"
  get "dashboard/next_page"
  get "dashboard/previous_page"
  get "dashboard/redraw"

  # authentication
  get "dashboard/login"
  get "dashboard/logout"

  #
  # Tag routes
  #
  get "tags" => 'tags#home'
  get "tag/activate/:name", to: 'tags#activate'
  get "tag/deactivate/:name", to: 'tags#deactivate'
  # add new tag
  get "tag/add/:name", to: 'tags#add'
  # remove tag
  get "tag/remove/:name", to: 'tags#remove'
  
  #
  # Item routes
  #

  # display specific item
  get "item/:name" => 'items#view'

  get "directory" => "directory#index"
  post "directory/import"

  # feedback viewport size and zoom level to app
  get "resize/:width/:height/:zoom", to: 'resize#resize'

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root :to => "dashboard#home"

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
