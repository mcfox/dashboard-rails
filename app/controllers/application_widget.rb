class ApplicationWidget < ::ApplicationController
  include SingletonHelper

  attr_singleton :widget_name, 'Widget'
  attr_singleton :widget_description
  attr_singleton :refresh_interval

  def initialize(request)
    self.request = request
  end

  def render_template(view_file=nil, *args)
    args << {template: view_file}
    render_to_string *args
  end

  def view(view_file=nil, klass=nil)
    class_caller = klass || (caller[0].match(/(\b\w+)\.rb/)[1] rescue '')
    action_caller = view_file || (caller[0].match(/`(.*)'/)[1] rescue '')
    view_file = "widgets/#{class_caller.sub('_widget','')}/#{action_caller}" unless lookup_context.find_all(view_file).any?
    instance_variable_set(:@view_file, view_file)
  end

end