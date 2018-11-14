Coin3::Application.routes.draw do
  match '/categories/:category_id/coins/page/:page' => 'coins#index'
  match '/coins/:coin_id/pics/page/:page' => 'pics#index'
  match 'collection' => 'collections#show'
  #match 'farm' => 'pics#farm'   # Assists with locating authorized images for download
  match 'help' => 'help#index'  
  match 'admin' => 'admin#index'
  match 'sitemap.xml' => 'sitemap#sitemap'
    
  resources :contributors, :pics, :ebay

  resources :coins do
    resources :pieces
		resources :pics
  end

  resources :collections do
    resources :pieces
    resources :coins
  end
  
  resources :categories do
    resources :coins
  end  

  resources :users do
    resource :collection
  end

  root :to => 'home#index'
  
end
