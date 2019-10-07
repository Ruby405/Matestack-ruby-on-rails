require_relative '../../support/utils'
include Utils

describe 'Legend Component', type: :feature, js: true do

  it 'Example 1' do

    class ExamplePage < Matestack::Ui::Page

      def response
        components {
          legend id: 'my-id', class: 'my-class' do
            plain 'Hello World' #optional content
          end
        }
      end

    end

    visit '/example'

    static_output = page.html

    expected_static_output = <<~HTML
    <legend id="my-id" class="my-class">
      Hello World
    </legend>
    HTML

    expect(stripped(static_output)).to include(stripped(expected_static_output))
  end

end
