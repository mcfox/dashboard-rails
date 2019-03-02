require_dependency "dashboard-rails/application_controller"

module DashboardRails
  class WidgetsController < ApplicationController

    def load
      widget = DashboardRails::Widget.new(params[:widget_name], self.request)
      content = widget.html(params[:widget_action])
    rescue Exception => e
      content = e.message
    ensure
      render html: content, layout: false
    end

    def user
      user_id = params[:id]
      @widgets_code = DashboardRails::User.where(user_id: user_id).pluck(:widget, :action).map{|r| "#{r[0]}_#{r[1]}"}
      render partial: 'widgets_list'
    end

    def index
      @user_id = params[:user_id] || current_user.id
    end

    def save
      user_id = params[:user_id]
      widgets = params[:widgets]
      widget_name_user = []
      action_user = []
      if user_id.present? && widgets.present?
        widgets.each do |widget|
          widget_name, action = widget.split('|')
          if widget_name && action
            widget_name_user << widget_name
            action_user << action
            DashboardRails::User.find_or_create_by(widget: widget_name, action: action, user_id: user_id)
          end
        end
      end
      DashboardRails::User.where(user_id: user_id).where.not(widget: widget_name_user, action: action_user).destroy_all
      flash[:success] = 'Alterações foram salvas com sucesso!'
      redirect_to dashboard-rails_path(user_id: user_id)
    end

  end
end