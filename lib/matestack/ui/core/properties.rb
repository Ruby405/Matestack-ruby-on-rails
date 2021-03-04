module Matestack
  module Ui
    module Core
      module Properties
        
        def self.included(base)
          base.extend ClassMethods
          base.send :prepend, Initializer
        end
        
        module Initializer
          def initialize(html_tag = nil, text = nil, options = {}, &block)
            extract_options(text, options)
            create_context
            super
          end
        end
        
        module ClassMethods
          def required(*args)
            @required = (@required || []).concat(args)
          end
          
          def optional(*args)
            @optional = (@optional || []).concat(args)
          end
          
          def required_property_keys
            @required
          end
      
          def optional_property_keys
            @optional
          end
        end
    
        def context 
          # find parent which should have a context
          # context only makes sense for non base components
          parent_context = while parent.present? && Matestack::Ui::Core::Base::CORE_COMPONENTS.include?(self.class)
            return parent.ctx if parent.respond_to?(:ctx)
          end
          @context ||= (parent_context || OpenStruct.new)
        end
        alias :ctx :context
        
        def required_property_keys
          self.class.required_property_keys || []
        end
        
        def optional_property_keys
          self.class.optional_property_keys || []
        end
        
        def create_context
          self.required_property_keys.uniq.each do |key|
            raise "required property '#{key}' is missing for '#{self.class}'" unless self.options.has_key? key
            context.send(:"#{key}=", self.options.delete(key))
          end if self.required_property_keys
          self.optional_property_keys.uniq.each do |key|
            context.send(:"#{key}=", self.options.delete(key))
          end if self.optional_property_keys
        end
    
      end
    end
  end
end