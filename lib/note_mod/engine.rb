module NoteMod
  class Engine < ::Rails::Engine
    isolate_namespace NoteMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end