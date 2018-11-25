module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@instance_count, 0)
  end

  module ClassMethods
    def instances
      class_variable_get(:@@instance_count)
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.class_variable_set(:@@instance_count, (self.class.class_variable_get(:@@instance_count) + 1))
    end
  end
end



   

