module ActionView
  module Helpers
    module FormHelper
      alias_method :old_label, :label
      def label(object_name, method, text = nil, options = {})
        text ||= I18n.t("activerecord.attributes.#{object_name}.#{method}")
        old_label object_name, method, text, options
      end
    end
  end
end
