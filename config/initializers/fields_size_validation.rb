module ActionView
  module Helpers
    class InstanceTag
      alias_method :old_to_input_field_tag, :to_input_field_tag

      def to_input_field_tag(field_type, options = {})
        if object.class.columns_hash[method_name]
          maxlenght = object.class.columns_hash[method_name].limit
          options[:maxlength] ||= maxlenght   # if the caller didn't specify a maximum length for this input field, then restrict it to the field size in the database
          maxlenght = options[:maxlength]
          maxlenght = 50 if maxlenght.nil? or maxlenght > 50
          options[:size] ||= maxlenght unless options[:size]
        end
        old_to_input_field_tag(field_type, options)
      end
    end
  end
end