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

  describe 'classes_for_scoped_css' do
    specify do
      helper.stub(:params).and_return({controller: 'controller_name', action: 'actionname'})
      expect(helper).to receive(:current_layout).and_return('layoutname')
      expect(helper.classes_for_scoped_css).to be == "layoutname-layout controller-name-controller actionname-action"
    end
  end

  describe 'current_layout' do
    specify do
      expect(helper).to receive_message_chain(:controller, :send).and_return("layoutname")
      expect(helper.current_layout).to be == "layoutname"
    end
  end
end
