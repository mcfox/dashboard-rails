Rails.application.routes.draw do


  namespace :taxweb_widgets do

    get 'widgets/load/:widget_name/:widget_action', to: 'widgets#load', as: 'load'

    get 'widgets', to: 'widgets#index', as: ''
    put 'widgets/save', to: 'widgets#save', as: 'save'

  end






end
