module Basemate
  module Ui
    module Core
      module ApplicationHelper

        def render_page(page_class, app_key=nil)
          page_class.new(nil, context: { params: params, request: request}, controller_instance: self).call(:show, nil, app_key)
        end

        def render_component(page_class, component_key)
          page_class.new(nil, context: { params: params, request: request}, controller_instance: self).call(:show, component_key)
        end

        def responder_for(page_class, options = {})
          if params[:only_page]
            render html: render_page(page_class)
          else
            unless params[:component_key].blank?
              render plain: render_component(page_class, params[:component_key])
            else
              if options[:app]
                render html: render_page(page_class, options[:app]), layout: true
              else
                render html: render_page(page_class), layout: true
              end
            end
          end
        end

      end
    end
  end
end
