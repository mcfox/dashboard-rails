require_dependency "taxweb_widgets/application_controller"

module TaxwebWidgets
  class GatewayController < ApplicationController

    layout false

    def load
      widget = TaxwebWidgets::Widget.new(params[:widget_name], self.request)
      content = widget.html(params[:widget_action])
    rescue Exception => e
      content = e.message
    ensure
      render html: content
    end

  end
end