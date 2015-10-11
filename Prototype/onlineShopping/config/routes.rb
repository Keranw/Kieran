Rails.application.routes.draw do
  resources :items
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'show/:id' => 'home#show'
  get 'item_managements/item_query' => 'item_managements#item_query'
  get 'item_managements/item_destroy/:id' => 'item_managements#item_destroy'
  get 'item_managements/item_new' => 'item_managements#item_new'
  post 'item_managements/item_create' => 'item_managements#item_create'
  patch 'item_managements/item_edit' => 'item_managements#item_edit'
  get 'item_managements/item_read/:id' => 'item_managements#item_read'
  get 'item_managements/item_show/:id' => 'item_managements#item_show'
  get 'home' => 'home#index'
  get 'home/result' => 'home#result'
  post 'home/search'=> 'home#search'
  patch 'home/buy' => 'home#buy'
  get 'home/trolley' => 'home#trolley'
  get 'home/delete_item_in_trolley/:id' => "home#delete_item_in_trolley"
  get 'home/trolley_clear' => "home#trolley_clear"
  post 'home/trolley_purchase' => "home#trolley_purchase"
  get 'order/my_orders' => 'orders#my_orders'
  get 'order/ask_cancel' => 'orders#ask_cancel'
  get 'order/pending_orders' => 'orders#pending_orders'
  get 'order/order_management' => 'orders#order_management'
  get 'order/approve_cancel' => 'orders#approve_cancel'
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
