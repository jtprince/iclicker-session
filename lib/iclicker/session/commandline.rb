require 'optparse'
require 'ostruct'

module Iclicker
  module Session
    module Commandline
      # returns [arg, options_struct]
      def self.parse(argv)
        opt = OpenStruct.new
        parser = OptionParser.new do |op|
          op.banner = "usage: #{File.basename(__FILE__)} [OPTS]"
          op.on("-f", "--frequency <xx>", "two letters e.g. 'cb'") {|v| opt.frequency = v }
          op.on("-h", "--help", "give some help") {|v| opt.help = v }
        end
        parser.parse!(argv)
        if opt.help
          puts parser
          exit 
        end
        [argv, opt]
      end
    end
  end
end
