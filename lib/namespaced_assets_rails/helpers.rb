require "namespaced_assets_rails/view_helpers/yojs_helper"

module NamespacedAssetsRails
  module Helpers
    def javascript_ready(&block)
      javascript_tag("$(function(){\n" + capture(&block) + "});").html_safe
    end

    def current_layout
      layout = controller.send(:_layout)

      if layout.instance_of? String
        layout.split('/').last
      else
        File.basename(layout.identifier).split('.').first
      end
    end

    def namespaced_javascript_calls
      @view_renderer.get_logged_view_paths
    end

    def classes_for_scoped_css
      classes = []
      classes << "#{current_layout}-layout"
      classes << "#{params[:controller].parameterize('-')}-controller"
      classes << "#{params[:action].parameterize('-')}-action"
      classes.join(" ").gsub("_", "-")
    end
  end
end
