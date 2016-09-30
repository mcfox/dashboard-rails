module TaxwebWidgets
  module ApplicationHelper

    def add_widget(widget_name, widget_action)
      widget = TaxwebWidgets::Widget.new(widget_name, self.request)
      content_tag(:div, '', id: "widget_#{widget_name}_#{widget_action}", class: 'widget', data: {tick: widget.param(:refresh_interval), url: taxweb_widgets_load_path(widget_name: widget_name, widget_action: widget_action)})
    end

    def widget_path(args=nil)
      my_params = {widget_name: params[:widget_name], widget_action: params[:widget_action]}
      my_params.merge!(args) if args.present?
      taxweb_widgets_load_path(my_params)
    end


    def widget_can?(widget_name, widget_action)
      TaxwebWidgets::User.where(user_id: current_user.id, widget: widget_name, action: widget_action).count > 0
    end

  end
end