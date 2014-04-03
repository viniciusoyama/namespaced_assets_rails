# encoding: utf-8
require 'spec_helper'

describe NamespacedAssetsRails::ViewHelpers::YojsHelper do
  let(:helper) { Class.new(ActionView::Base) do
      include NamespacedAssetsRails::ViewHelpers #need javascript_ready
    end.new
  }

  describe "load_yojs" do
    before(:each) { helper.stub(:params).and_return({ :action => "nomeaction", :controller => "nomecontroller" }.with_indifferent_access) }

    specify do
      generator_mock = double()
      generator_mock.should_receive(:generate_yojs_calls).and_return("<script>JAVASCRIPTDERETORNO</script>")
      NamespacedAssetsRails::ViewHelpers::YojsHelper::YojsCallGenerator.should_receive(:new).with("nomecontroller", "nomeaction", {:app_name => 'app_teste'}).and_return(generator_mock)
      helper.load_yojs(:app_name => 'app_teste').should be == "<script>\n//<![CDATA[\n$(function(){\n&lt;script&gt;JAVASCRIPTDERETORNO&lt;/script&gt;});\n//]]>\n</script>"
    end
  end
end

