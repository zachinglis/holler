module Railslove
  module Plugins
    module SerializeFu
      
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        
   
        def serialize_fu(options={})
          class_inheritable_accessor :serialize_options
          self.serialize_options = options
  	      include Railslove::Plugins::SerializeFu::InstanceMethods
        end
      
      end
      
      module InstanceMethods
        def to_json(options={})
          super(self.serialize_options.merge(options))
        end
        def to_xml(options={})
          super(self.serialize_options.merge(options))
        end
      end
      
    end
  end
end