require 'action_view'

module ActionView
  class Renderer
    def render_with_logging(context, options,  &block)
      @called_templates_path ||= []
      if options.key?(:partial)
        @called_templates_path << options[:partial]
      else
        @called_templates_path.concat(options[:prefixes])
        render_template(context, options)
      end
      render_without_logging(context, options, &block)
    end
    alias_method_chain :render, :logging

    def get_logged_view_paths
      @called_templates_path
    end

  end
end
