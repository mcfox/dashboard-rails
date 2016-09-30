require_dependency "taxweb_widgets/application_controller"

module TaxwebWidgets
  class WidgetsController < ApplicationController

    def load
      widget = TaxwebWidgets::Widget.new(params[:widget_name], self.request)
      content = widget.html(params[:widget_action])
    rescue Exception => e
      content = e.message
    ensure
      render html: content, layout: false
    end

    def index
      @widgets_code = TaxwebWidgets::User.where(user_id: current_user.id).map{|r| "#{r.widget}_#{r.action}"}
    end

    def save
      widgets = params[:widgets]
      widget_name_user = []
      action_user = []
      widgets.each do |widget|
        widget_name, action = widget.split('|')
        if widget_name && action
          widget_name_user << widget_name
          action_user << action
          TaxwebWidgets::User.find_or_create_by(widget: widget_name, action: action, user_id: current_user.id)
        end
        TaxwebWidgets::User.where(user_id: current_user.id).where.not(widget: widget_name_user, action: action_user, ).destroy_all
      end
      flash[:success] = 'Alterações foram salvas com sucesso!'
      redirect_to taxweb_widgets_path
    end

  end
end