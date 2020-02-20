module Matestack::Ui::Core::App

  # TODO: Similar to page, App doesn't need everything base offers atm
  class App < Matestack::Ui::Core::Component::Base

    def initialize(page_class, controller_instance)
      context = {
        view_context: controller_instance.view_context,
        params: controller_instance.params,
        request: controller_instance.request
      }

      super(nil, context: context)

      @page_class = page_class
      @controller_instance = controller_instance
    end

    def show()
      prepare
      response
      render :app
    end

    # Default "response" for just rendering the page without a more
    # sophisticated app being supplied
    def response
      page_content
    end

    def page_content
      add_child @page_class,
                controller_instance: @controller_instance,
                context: context
    end
  end
end
