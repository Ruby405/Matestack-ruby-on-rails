module Matestack
  module Ui 
    module Core
      module ComponentRegistry
        
        def self.included(base)
          base.extend ClassMethods
        end
        
        module ClassMethods
          def register(**components)
            raise 'is not a hash' unless components.to_h.is_a? Hash
            components.to_h.each do |key, klass|
              raise "#{key} overrides base method" if Base.respond_to?(key, true)
              Base.define_method(key) do |text = nil, options = nil, &block|
                if text.is_a?(Hash) && options.nil?
                  options = text
                  text = nil
                end
                klass.(text, options, &block)
              end
            end
          end
        end
        
        
      end
    end
  end
end