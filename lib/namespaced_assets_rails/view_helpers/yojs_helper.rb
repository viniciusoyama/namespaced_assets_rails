require "namespaced_assets_rails/view_helpers/yojs_helper/yojs_call_generator"

module NamespacedAssetsRails
  module Helpers
    module YojsHelper
      def load_yojs_recursively(options = {})
        call_generator = YojsCallGenerator.new(options[:main_namespace].to_s, params[:last_namespace].to_s, options)
        javascript_ready { call_generator.generate_yojs_calls() }.html_safe
      end

      def load_yojs_one_call(options = {})
        call_generator = YojsCallGenerator.new
        parameterized_namespaces = options[:namespaces].map do |ns|
          ns.parameterize(".")
        end
        calls = call_generator.generate_conditional_function_calling_for_namespaces(parameterized_namespaces).join("\n").html_safe
        javascript_ready { calls }.html_safe
      end
    end
  end
end
