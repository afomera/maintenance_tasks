# frozen_string_literal: true
module MaintenanceTasks
  # The engine's main class, which defines its namespace. The engine is mounted
  # by the host application.
  class Engine < ::Rails::Engine
    isolate_namespace MaintenanceTasks

    config.after_initialize do
      unless Rails.autoloaders.zeitwerk_enabled?
        eager_load!
        tasks_module = MaintenanceTasks.tasks_module.name.underscore
        Dir["#{Rails.root}/app/tasks/#{tasks_module}/*.rb"].each do |file|
          require_dependency(file)
        end
      end
    end
  end
end
