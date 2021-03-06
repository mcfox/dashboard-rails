module DashboardRails
  module ApplicationHelper

    def add_widget(widget_name, widget_action)
      widget = DashboardRails::Widget.new(widget_name, self.request)
      content_tag(:div, '', id: "widget_#{widget_name}_#{widget_action}", class: 'widget', data: {tick: widget.param(:refresh_interval), url: dashboard-rails_load_path(widget_name: widget_name, widget_action: widget_action)})
    end

    def widget_path(args=nil)
      my_params = {widget_name: params[:widget_name], widget_action: params[:widget_action]}
      my_params.merge!(args) if args.present?
      dashboard-rails_load_path(my_params)
    end

    def user_can_widget?(widget_name, widget_action)
      DashboardRails::User.where(user_id: current_user.id, widget: widget_name, action: widget_action).count > 0
    end

  end
end