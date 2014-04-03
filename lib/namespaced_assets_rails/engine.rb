require 'rails/engine'

module NamespacedAssetsRails
  class Engine < ::Rails::Engine
    initializer "Codus.view_helpers" do |app|
      ActionView::Base.send :include, NamespacedAssetsRails::Helpers
    end
  end
end
