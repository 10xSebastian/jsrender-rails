require 'sprockets'
require 'tilt'
require 'action_view'
require 'action_view/helpers'

module JsrenderRails
  class Jsrender < Tilt::Template
    include ActionView::Helpers::JavaScriptHelper

    def self.default_mime_type
      'application/javascript'
    end

    def prepare
      @prefix = normalize_prefix(Rails.configuration.jsrender.prefix)
    end

    def evaluate(scope, locals, &block)
      %{(function($) {$.views.templates("#{template_name(scope)}", "#{escape_javascript(data)}");})((typeof jQuery !== "undefined" && jQuery !== null) ? jQuery : {views: jsviews});}
    end

    private

    def normalize_prefix(prefix)
      if prefix.respond_to?(:length) && prefix.length > 0
        prefix = prefix[1, prefix.length - 1] if prefix.start_with?("/")
        prefix += "/" unless prefix.end_with?("/")
      end

      prefix
    end

    def template_name(scope)
      scope.logical_path.sub(@prefix, "")
    end
  end
end
