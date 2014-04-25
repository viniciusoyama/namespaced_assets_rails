module NamespacedAssetsRails
  module Helper
    def javascript_ready(&block)
      javascript_tag("$(function(){\n" + capture(&block) + "});").html_safe
    end

    def namespaced_javascript_calls(options = {})
      options = {
        root_namespace_name: 'app'
      }.merge(options)
      full_namespaces_to_call = []
      full_namespaces_to_call << "#{options[:root_namespace_name]}.#{params[:controller].parameterize('.')}.#{params[:action]}"
      full_namespaces_to_call << "#{options[:root_namespace_name]}.#{params[:controller].parameterize('.')}.#{RenderedViewsLogger.get_rendered_view_name}"
      RenderedViewsLogger.get_logged_views_paths.each do |views_path|
        full_namespaces_to_call << "#{options[:root_namespace_name]}.#{views_path.parameterize('.')}"
      end
      javascript_ready { generate_conditional_yojs_calling_for_namespaces(full_namespaces_to_call) }.html_safe
    end

    def generate_conditional_yojs_calling_for_namespaces(namespaces = [])
      namespaces.map do |call_definition|
        "
          if (yojs.isDefined(\"#{call_definition}\")) {
            yojs.call(\"#{call_definition}\");
          }
        "
      end.join("\n").html_safe
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
      classes << "#{RenderedViewsLogger.get_rendered_view_name}-file"
      classes.join(" ").gsub("_", "-")
    end
  end
end
