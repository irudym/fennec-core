Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :v1 do
    get 'devices/trash'
    get 'devices/trash/pages/:id', to: 'devices#trash_pages'
    get 'devices/pages'
    get 'devices/pages/:id', to: 'devices#pages'
    put 'devices/trash/:id', to: 'devices#restore'
    resources :devices
  end

end
