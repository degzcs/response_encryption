require 'active_model'
class ResponseEncryption::ActiveModelService
  include ::ActiveModel::Model
  ActiveModel::Errors.class_eval do
    # Add errors from another ActiveModel::Errors
    # @params errors [ ActiveModel::Errors ]
    # @model_name [ String ]
    def add_many(errors, label=nil)
      if errors.is_a? ActiveModel::Errors
        errors.each do |attribute, message|
          label ||= attribute
          add(label, message)
        end
      end
    end
  end

  def initialize(options={})
    super
    @errors = ::ActiveModel::Errors.new(self)
  end

  # @return [ Boolean ]
  def valid?
    errors.blank?
  end
end