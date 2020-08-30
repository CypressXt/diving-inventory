Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tanks, only: [:index, :show, :new, :create, :delete, :destroy] do
    get 'qrcode' => 'tanks#qrcode'
    get 'delete' => 'tanks#delete'
  end
end
