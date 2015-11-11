Rails.application.routes.draw do
  resources :nodes do
    resources :log_lines
  end
  resources :logs

  root 'nodes#index'
end
