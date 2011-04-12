module Achievable
  module DSL
    extend ActiveSupport::Concern
    
    module ClassMethods
      def achievable(attribute, achievement, options = {})
        options.assert_valid_keys(:receiver, :condition)
        method_name = :"achieve_#{achievement}"
        
        define_method(method_name) do |*args|
          attr_changed = :"#{attribute.to_s}_changed?"
          return unless (respond_to? attr_changed) && send(attr_changed)
          receiver = options[:receiver] ? send(options[:receiver]) : self
          raise 'object must respond to achieve' unless receiver.respond_to? :achieve
          receiver.achieve(achievement, options)
        end
      
        send(:"after_update", method_name)
      end
    end
    
  end
end