#
# Author:: Bryan McLellan (btm@loftninjas.org)
# Author:: Tyler Cloke (<tyler@chef.io>)
# Copyright:: Copyright 2009-2016, Bryan McLellan
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/resource"

class Chef
  class Resource
    class Cron < Chef::Resource
      description "Use the cron resource to manage cron entries for time-based job scheduling."\
                  " Properties for a schedule will default to * if not provided. The cron resource"\
                  " requires access to a crontab program, typically cron."

      identity_attr :command

      state_attrs :minute, :hour, :day, :month, :weekday, :user

      default_action :create
      allowed_actions :create, :delete

      def initialize(name, run_context = nil)
        super
        @minute = "*"
        @hour = "*"
        @day = "*"
        @month = "*"
        @weekday = "*"
        @command = nil
        @user = "root"
        @mailto = nil
        @path = nil
        @shell = nil
        @home = nil
        @time = nil
        @environment = {}
      end

      def minute(arg = nil)
        if arg.is_a?(Integer)
          converted_arg = arg.to_s
        else
          converted_arg = arg
        end
        begin
          if integerize(arg) > 59 then raise RangeError end
        rescue ArgumentError
        end
        set_or_return(
          :minute,
          converted_arg,
          :kind_of => String
        )
      end

      def hour(arg = nil)
        if arg.is_a?(Integer)
          converted_arg = arg.to_s
        else
          converted_arg = arg
        end
        begin
          if integerize(arg) > 23 then raise RangeError end
        rescue ArgumentError
        end
        set_or_return(
          :hour,
          converted_arg,
          :kind_of => String
        )
      end

      def day(arg = nil)
        if arg.is_a?(Integer)
          converted_arg = arg.to_s
        else
          converted_arg = arg
        end
        begin
          if integerize(arg) > 31 then raise RangeError end
        rescue ArgumentError
        end
        set_or_return(
          :day,
          converted_arg,
          :kind_of => String
        )
      end

      def month(arg = nil)
        if arg.is_a?(Integer)
          converted_arg = arg.to_s
        else
          converted_arg = arg
        end
        begin
          if integerize(arg) > 12 then raise RangeError end
        rescue ArgumentError
        end
        set_or_return(
          :month,
          converted_arg,
          :kind_of => String
        )
      end

      def weekday(arg = nil)
        if arg.is_a?(Integer)
          converted_arg = arg.to_s
        else
          converted_arg = arg
        end
        begin
          error_message = "You provided '#{arg}' as a weekday, acceptable values are "
          error_message << Provider::Cron::WEEKDAY_SYMBOLS.map { |sym| ":#{sym}" }.join(", ")
          error_message << " and a string in crontab format"
          if (arg.is_a?(Symbol) && !Provider::Cron::WEEKDAY_SYMBOLS.include?(arg)) ||
              (!arg.is_a?(Symbol) && integerize(arg) > 7) ||
              (!arg.is_a?(Symbol) && integerize(arg) < 0)
            raise RangeError, error_message
          end
        rescue ArgumentError
        end
        set_or_return(
          :weekday,
          converted_arg,
          :kind_of => [String, Symbol]
        )
      end

      def time(arg = nil)
        set_or_return(
          :time,
          arg,
          :equal_to => Chef::Provider::Cron::SPECIAL_TIME_VALUES
        )
      end

      def mailto(arg = nil)
        set_or_return(
          :mailto,
          arg,
          :kind_of => String
        )
      end

      def path(arg = nil)
        set_or_return(
          :path,
          arg,
          :kind_of => String
        )
      end

      def home(arg = nil)
        set_or_return(
          :home,
          arg,
          :kind_of => String
        )
      end

      def shell(arg = nil)
        set_or_return(
          :shell,
          arg,
          :kind_of => String
        )
      end

      def command(arg = nil)
        set_or_return(
          :command,
          arg,
          :kind_of => String
        )
      end

      def user(arg = nil)
        set_or_return(
          :user,
          arg,
          :kind_of => String
        )
      end

      def environment(arg = nil)
        set_or_return(
          :environment,
          arg,
          :kind_of => Hash
        )
      end

      private

      # On Ruby 1.8, Kernel#Integer will happily do this for you. On 1.9, no.
      def integerize(integerish)
        Integer(integerish)
      rescue TypeError
        0
      end
    end
  end
end
