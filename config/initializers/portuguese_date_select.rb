module ActionView
  module Helpers
    class InstanceTag
      alias_method :old_to_date_select_tag, :to_date_select_tag

      def to_date_select_tag(options = {}, html_options = {})

        options[:start_year] =  1900

        old_to_date_select_tag(options, html_options)
      end

    end
  end
end