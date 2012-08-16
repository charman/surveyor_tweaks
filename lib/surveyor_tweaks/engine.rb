#  Share the controllers and views in this Gem with any Rails application that uses the Gem
#
#  Per the Rails docs:
#    Rails::Engine allows you to wrap a specific Rails application or subset of functionality
#    and share it with other applications.  Since Rails 3.0, every Rails::Application is just
#    an engine, which allows for simple feature and application sharing.

module SurveyorTweaks
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path("../../", __FILE__)
  end
end
