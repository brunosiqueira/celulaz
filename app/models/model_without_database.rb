# To change this template, choose Tools | Templates
# and open the template in the editor.

class ModelWithoutDatabase
  def save() raise NotImplementedError end
  def save!() raise NotImplementedError end
  def update_attribute() raise NotImplementedError end
  def new_record?() true end

  include ActiveRecord::Validations

  def initialize(attributes = nil)
    self.attributes = attributes
  end

  def attributes=(new_attributes)
    return unless new_attributes
    new_attributes.each do |k, v|
      k = "#{k}="
      send(k, v) if respond_to?(k)
    end
  end

  def self.human_name(options = {})
    defaults = self_and_descendents_from_active_record.map do |klass|
      :"#{klass.name.underscore}"
    end
    defaults << self.name.humanize
    I18n.translate(defaults.shift, {:scope => [:activerecord, :models], :count => 1, :default => defaults}.merge(options))
  end

  def self.human_attribute_name(attribute_key_name, options = {})
    defaults = self_and_descendents_from_active_record.map do |klass|
      :"#{klass.name.underscore}.#{attribute_key_name}"
    end
    defaults << options[:default] if options[:default]
    defaults.flatten!
    defaults << attribute_key_name.humanize
    options[:count] ||= 1
    I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activerecord, :attributes]))
  end

  def self.self_and_descendants_from_active_record
    self_and_descendents_from_active_record
  end

  def self.self_and_descendents_from_active_record#nodoc:
    klass = self
    classes = [klass]
    while klass != klass.base_class
      classes << klass = klass.superclass
    end
    classes
  rescue
    # OPTIMIZE this rescue is to fix this test: ./test/cases/reflection_test.rb:56:in `test_human_name_for_column'
    # Appearantly the method base_class causes some trouble.
    # It now works for sure.
    [self]
  end

  def self.columns_hash
    {}
  end

end
