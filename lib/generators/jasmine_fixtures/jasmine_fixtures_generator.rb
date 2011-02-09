require "rails/generators/base"

class JasmineFixturesGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../generators/jasmine-fixtures/templates', __FILE__)

  def install
    directory "spec"
    readme "INSTALL"
  end

end
