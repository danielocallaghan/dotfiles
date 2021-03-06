require "rubygems"

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      pp @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end
