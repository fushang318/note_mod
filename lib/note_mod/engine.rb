module NoteMod
  class Engine < ::Rails::Engine
    isolate_namespace NoteMod
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
      User.class_eval do
        has_many :notes, class_name: 'NoteMod::Note'
      end
    end
  end
end