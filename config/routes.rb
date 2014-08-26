Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :shipping_matrices
  end
end
