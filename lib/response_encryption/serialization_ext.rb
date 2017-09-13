begin
  require 'action_controller'
  require 'action_controller/serialization'
  # mokey patch for add context to Serilization options
  ActionController::Serialization.class_eval do
    def get_serializer(resource, options = {})
      unless use_adapter?
        warn 'ActionController::Serialization#use_adapter? has been removed. '\
          "Please pass 'adapter: false' or see ActiveSupport::SerializableResource.new"
        options[:adapter] = false
      end

      options.fetch(:namespace) { options[:namespace] = namespace_for_serializer }
      options[:context] = context# TODO: take this context var and define it into app controller.

      serializable_resource = ActiveModelSerializers::SerializableResource.new(resource, options)
      serializable_resource.serialization_scope ||= options.fetch(:scope) { serialization_scope }
      serializable_resource.serialization_scope_name = options.fetch(:scope_name) { _serialization_scope }
      # For compatibility with the JSON renderer: `json.to_json(options) if json.is_a?(String)`.
      # Otherwise, since `serializable_resource` is not a string, the renderer would call
      # `to_json` on a String and given odd results, such as `"".to_json #=> '""'`
      serializable_resource.adapter.is_a?(String) ? serializable_resource.adapter : serializable_resource
    end
  end
rescue LoadError
end
