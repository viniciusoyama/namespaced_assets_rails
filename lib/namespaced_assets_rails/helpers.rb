require "namespaced_assets_rails/view_helpers/yojs_helper"

module NamespacedAssetsRails
  module Helpers
    include NamespacedAssetsRails::Helpers::YojsHelper

    def javascript_ready(&block)
      javascript_tag("$(function(){\n" + capture(&block) + "});").html_safe
    end

    def namespaced_javascript_calls(options = {})
      options = {
        app_name: current_layout
      }.merge(options)

      controller_action_namespaces = options.merge(main_namespace: params[:controller], last_namespace: params[:action])
      namespaces_calls = load_yojs_recursively(controller_action_namespaces).html_safe

      logged_paths = @view_renderer.get_logged_paths

      unless logged_paths[:rendered_template_path].blank?
        namespaces_calls += load_yojs_one_call(namespaces: [logged_paths[:rendered_template_path]]).html_safe
      end

      unless logged_paths[:rendered_files_paths].empty?
        namespaces_calls += load_yojs_one_call(namespaces: logged_paths[:rendered_files_paths]).html_safe
      end

      unless logged_paths[:rendered_partials_paths].empty?
        namespaces_calls += load_yojs_one_call(namespaces: logged_paths[:rendered_partials_paths]).html_safe
      end

      namespaces_calls
    end

    def initialize_namespaced_css_classes
      initializer_string = "$('body').addClass('#{classes_for_scoped_css}')".html_safe
      javascript_ready { initializer_string }.html_safe
    end

    def current_layout
      layout = controller.send(:_layout)

      if layout.instance_of? String
        layout.split('/').last
      else
        File.basename(layout.identifier).split('.').first
      end
    end

    def classes_for_scoped_css
      classes = []
      classes << "#{current_layout}-layout"
      classes << "#{params[:controller].parameterize('-')}-controller"
      classes << "#{params[:action].parameterize('-')}-action"
      logged_paths = @view_renderer.get_logged_paths
      unless logged_paths[:rendered_template_path].blank?
        classes << "#{logged_paths[:rendered_template_path].parameterize('-')}-template"
      end
      classes.join(" ").gsub("_", "-")
    end
  end
end
