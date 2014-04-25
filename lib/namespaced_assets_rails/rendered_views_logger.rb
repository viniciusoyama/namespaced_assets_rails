module NamespacedAssetsRails
  module RenderedViewsLogger
    def self.subscribe_for_logging
      ActiveSupport::Notifications.subscribe("render_template.action_view") do |_name, _start, _finish, _id, payload|
        RenderedViewsLogger.insert_new_event_log(payload)
      end

      ActiveSupport::Notifications.subscribe("!render_template.action_view") do |_name, _start, _finish, _id, payload|
        RenderedViewsLogger.insert_new_event_log(payload)
      end
    end

    def self.insert_new_event_log(payload)
      RequestStore.store[:rendered_views_logged_views] ||= []
      if payload.has_key?(:virtual_path)
        RequestStore.store[:rendered_views_logged_views] << payload[:virtual_path]
      else
        # the last logged path was the rendered view
        RequestStore.store[:rendered_views_rendered_view_for_action] = RequestStore.store[:rendered_views_logged_views].last
      end
    end

    def self.get_logged_views_paths
      RequestStore.store[:rendered_views_logged_views].uniq
    end

    def self.get_rendered_view_name
      RequestStore.store[:rendered_views_rendered_view_for_action].split("/").last
    end
  end
end
