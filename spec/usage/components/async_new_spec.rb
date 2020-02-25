require_relative "../../support/utils"
include Utils

# Temporary new home for async to get the new examples going
# Examples adapted from the original async_spec
describe Matestack::Ui::Core::Async::Async, type: :feature, js: true do
  it "Example 1 - Rerender on event on page-level" do

    _my_async_component = Class.new(described_class) do
      def response
        div id: "my-div" do
          plain "#{DateTime.now.strftime('%Q')}"
        end
      end

      def self.name
        "Foo"
      end

      register_self_as(:my_async_component)
    end

    class ExamplePage < Matestack::Ui::Page

      def response
        my_async_component rerender_on: "my_event"
      end

    end

    visit "/example"

    # binding.pry

    element = page.find("#my-div")
    before_content = element.text

    binding.pry

    page.execute_script('MatestackUiCore.matestackEventHub.$emit("my_event")')

    # TODO: show Jonas re flakies
    expect(page).to have_no_content(before_content)
  end

end
