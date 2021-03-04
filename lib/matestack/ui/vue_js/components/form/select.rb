module Matestack
  module Ui
    module VueJs
      module Components
        module Form
          class Select < Matestack::Ui::VueJs::Components::Form::Base
            vue_name 'matestack-ui-core-form-select'

            def response
              div class: 'matestack-ui-core-form-select' do
                label input_label, for: id if input_label
                select select_attributes do
                  if placeholder
                    option value: nil, disabled: true, selected: init_value.nil?, text: placeholder
                  end
                  select_options.to_a.each do |item|
                    option item_label(item), value: item_value(item), disabled: item_disabled?(item)
                  end
                end
                render_errors
              end
            end

            def component_id
              "select-component-for-#{key}"
            end

            def config
              {
                init_value: init_value || [].to_json,
              }
            end

            def select_attributes
              attributes.merge({
                multiple: multiple,
                id: id,
                ref: "select#{'.multiple' if multiple}.#{key}",
                'value-type': item_value(select_options.first).is_a?(Integer) ? Integer : nil,
                'init-value': init_value || [].to_json,
              })
            end

            # select options

            def select_options
              @select_options ||= options.delete(:options)
            end

            # calculated attributes

            def item_value(item)
              item.is_a?(Array) ? item.last : item
            end
            
            def item_label(item)
              item.is_a?(Array) ? item.first : item
            end

            def item_id(item)
              "#{key}_#{item_value(item)}"
            end

            def item_disabled?(item)
              disabled_options && disabled_options.to_a.include?(item)
            end

            # attributes

            def disabled_options
              @disabled_options ||= options.delete(:disabled_options)
            end

          end
        end
      end
    end
  end
end