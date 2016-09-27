Rails.application.routes.draw do

  namespace :taxweb_widgets do
    resources :alerts do
      collection do
        get 'user', to: 'alerts#user', as: 'user'
      end
    end
    get 'gateway', to: 'gateway#index', as: 'list'
    put 'gateway/:id', to: 'gateway#read', as: 'read'
    delete 'gateway/:id', to: 'gateway#unread', as: 'unread'
  end

end
