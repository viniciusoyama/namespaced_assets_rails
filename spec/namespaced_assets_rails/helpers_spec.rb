# encoding: utf-8
require 'spec_helper'

describe NamespacedAssetsRails::Helpers do
  let(:helper) { Class.new(ActionView::Base) do
      include NamespacedAssetsRails::Helpers
    end.new
  }

  describe "javascript_ready" do
    specify do
      expect(helper.javascript_ready do
        "CONTEUDO JAVASCRIPT"
      end).to be == "<script>\n//<![CDATA[\n$(function(){\nCONTEUDO JAVASCRIPT});\n//]]>\n</script>"
    end
  end

  describe 'namespaced_javascript_calls' do
    pending "todo"
  end

  describe 'current_layout' do
    pending "todo"
  end
end
