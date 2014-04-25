require 'action_view'

module ActionView
  class Renderer
    class RenderLogSingleton
      include Singleton
      attr_accessor :logged_namespaces,
                    :logged_rendered_template_path,
                    :logged_partials_paths,
                    :logged_files_paths

      def initialize
        super
        puts "looo"
        self.logged_namespaces = []
        self.logged_rendered_template_path = ""
        self.logged_partials_paths = []
        self.logged_files_paths = []
      end

      def push_namespace(namespace)
        self.logged_namespaces.push(namespace)
      end

      def push_partial(partial)
        self.logged_partials_paths.push(partial)
      end

      def push_file(file)
        self.logged_files_paths.push(file)
      end

      def get_logged_paths
        {
          namespaces: logged_namespaces.uniq,
          rendered_template_path: logged_rendered_template_path,
          rendered_partials_paths: logged_partials_paths.uniq,
          rendered_files_paths: logged_files_paths.uniq
        }
      end
    end

    def render_with_logging(context, options,  &block)
      if options.key?(:partial)
        RenderLogSingleton.instance.push_partial options[:partial]
      elsif options.key?(:prefixes)
        options[:prefixes].each do |namespace|
          RenderLogSingleton.instance.push_namespace namespace
        end
        RenderLogSingleton.instance.logged_rendered_template_path = "#{options[:prefixes].first}/#{options[:action]}" unless options[:action].blank?
        RenderLogSingleton.instance.logged_rendered_template_path = "#{options[:prefixes].first}/#{options[:template]}" unless options[:template].blank?

        render_template(context, options)
      elsif options.key?(:file)
        RenderLogSingleton.instance.push_file "#{options[:file]}" unless options[:file].blank?
      end
      render_without_logging(context, options, &block)
    end
    alias_method_chain :render, :logging

    def get_logged_paths
      RenderLogSingleton.instance.get_logged_paths
    end

  end
end
