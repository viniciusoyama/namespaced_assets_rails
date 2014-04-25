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
      RequestStore.store[:logged_views] ||= []
      if payload.has_key?(:virtual_path)
        RequestStore.store[:logged_views] << payload[:virtual_path]
      else
        # last logged view was the view for action
        RequestStore.store[:rendered_view_name] = RequestStore.store[:logged_views].pop.split('/').last
      end
    end

    def self.get_logged_views_paths
      RequestStore.store[:logged_views].uniq
    end

    def self.get_rendered_view_name
      RequestStore.store[:rendered_view_name]
    end
  end
end
