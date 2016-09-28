module TaxwebWidgets
  class Widget
    def self.load(widget_name, widget_action)
      klass_name = Object.const_get "#{widget_name}_widget".classify
      klass = klass_name.new
      content = klass.send widget_action
      view_file = (klass.instance_variables.include?(:@view_file) ? klass.instance_variable_get(:@view_file) : klass.view(widget_action, widget_name))
      klass.render_template(view_file) rescue content
    end
  end
end