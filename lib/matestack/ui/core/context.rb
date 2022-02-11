module Matestack
  module Ui
    module Core
      class Context < ActiveSupport::CurrentAttributes

        attribute :layout
        attribute :parent
        attribute :isolated_parent
        attribute :params
        attribute :controller
        attribute :component_block
        attribute :async_components

      end
    end
  end
end
