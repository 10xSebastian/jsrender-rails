require "spec_helper"

describe JsrenderRails::Jsrender do
  before { Rails.application.assets.cache = {} }

  it "adds jsrender to the load path" do
    Rails.application.assets["jsrender"].should_not be_nil
  end

  it "compiles templates with the .tmpl extension" do
    template = Rails.application.assets["views/user"]
    template.to_s.should == %{jsviews.templates("views/user", "<div class=\\\"user\\\">{{>name}}<\\/div>\\n");}
  end

  context "when prefix is set" do
    it "removes the prefix from the template name" do
      Rails.configuration.jsrender.prefix = "views"
      template = Rails.application.assets["views/user"]
      template.to_s.should include('"user"')
    end

    it "normalizes template prefixes by removing extraneous slashes" do
      Rails.configuration.jsrender.prefix = "/views/"
      template = Rails.application.assets["views/user"]
      template.to_s.should include('"user"')
    end
  end
end
