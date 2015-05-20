class Factory
 def self.new *args,&block

   Class.new do
      args.each  do |i|
      attr_accessor i
      end

     define_method :initialize do |*init_args|
       init_args.each_with_index do |value,index|
        instance_variable_set("@#{args[index]}", value)
       end
     end


      def [](key)
       return instance_variable_get(instance_variables[key]) if key.kind_of?(Integer)
       return self.send(key)
      end
      
      class_eval &block if block_given?
   end


  end
end
Customer = Factory.new(:name) do

  def greeting
    "Hello #{name}!"
  end
end

jo = Customer.new("Joe Smith")
puts jo.name
puts jo["name"]
puts jo[:name]
puts jo[0]
puts jo.greeting