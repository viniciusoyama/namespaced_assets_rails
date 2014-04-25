require 'rails/engine'

module NamespacedAssetsRails
  class Engine < ::Rails::Engine
    initializer "namespaced_assets_rails.configure_view_helpers" do |app|
      ActionView::Base.send :include, NamespacedAssetsRails::Helper
    end

    initializer "namespaced_assets_rails.configure_rendered_views_logger" do |app|
      NamespacedAssetsRails::RenderedViewsLogger.subscribe_for_logging
    end
  end
end
