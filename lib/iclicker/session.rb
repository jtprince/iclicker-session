require "iclicker/session/version"
require 'iclicker/session/commandline'

module Iclicker
  COMMAND = 'iclickerpoll.py'
  module Session
    class << self

      def run(argv)
        (argv, opt) = Commandline.parse(argv)
        cmd = [COMMAND]
        cmd << "--frequency #{opt.frequency}" if opt.frequency
        cmd << "--type alpha"
        cmd_s = cmd.join(" ")
        cmd_s << " 2>&1"

        pid = nil
        begin
          pr = IO.popen cmd_s
          pid = pr.pid
          p pid
          loop do
            sleep 1
            puts "INCOMING"
            p pr.gets
          end
        rescue
          puts "going to send signal to #{pid}"
          Process.kill("INT", pid) if pid
        end

        trap("INT") do 
          puts "going to send signal to #{pid}"
          Process.kill("INT", pid) if pid
          exit
        end

#        IO.popen(cmd_s, 'r') do |pipe|
          #puts "parent pid: #{$$}, popen return (child) pid: #{pipe.pid}"
          #10.times do 
            #puts line = pipe.gets       pid from child
          #end
          #puts "child says it's pid is: "+line
          #Process.kill 'INT', pipe.pid
          #childs_last_word = pipe.gets
          #if childs_last_word
            #puts "child's last word: " + childs_last_word
          #end
        #end
        #puts "child's exit code: #{$?.exitstatus}"

      end
    end
  end
end
