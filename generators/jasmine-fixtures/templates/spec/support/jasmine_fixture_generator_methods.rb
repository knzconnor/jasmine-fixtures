# Add fixture-generation methods to ControllerExampleGroup. We load
# this file within our spec_helper.rb

RSpec::Rails::ControllerExampleGroup.class_eval do
  # Saves the markup to a fixture file using the given name
  def save_fixture(markup, name)
    fixture_path = Rails.root.join('tmp', 'jasmine_fixtures')
    FileUtils.mkdir_p(fixture_path)

    fixture_file = File.join(fixture_path, "#{name}.jasmine_fixture")
    File.open(fixture_file, 'w') do |file|
      file.puts(markup)
    end
  end

  # From the controller spec response body, extracts html identified
  # by the css selector.
  def html_for(selector)
    doc = Nokogiri::HTML(response.body)
    content = doc.at_css(selector).to_s
    convert_body_tag_to_div(content)
  end

  # Many of our css and jQuery selectors rely on a class attribute we
  # normally embed in the <body>. For example:
  #
  # <body class="workspaces show">
  #
  # Here we convert the body tag to a div so that we can load it into
  # the document running js specs without embedding a <body> within a <body>.
  def convert_body_tag_to_div(markup)
    markup.gsub("<body", '<div').gsub("</body>", "</div>")
  end
end