Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'metar/ping' => 'application#ping'
  get 'metar/info' => 'application#metar_info'
end
