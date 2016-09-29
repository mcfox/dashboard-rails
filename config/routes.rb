Rails.application.routes.draw do


  namespace :taxweb_widgets do
    # get 'gateway', to: 'gateway#index', as: 'list'

    # delete 'gateway/:id', to: 'gateway#unread', as: 'unread'

    get 'load/:widget_name/:widget_action', to: 'gateway#load', as: 'load'
  end

end
