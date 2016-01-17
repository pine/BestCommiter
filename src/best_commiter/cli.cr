require "option_parser"

require "./config"
require "./commands/*"
require "./models/*"
require "./option_parser"
require "./printer"

module BestCommiter
  class CLI
    def initialize
    end

    def try_run(args : Array(String))
      begin
        run(args)
      rescue OptionParser::MissingOption
        puts "Missing arguments"
      end
    end

    protected def run(args : Array(String))
      wrapper = OptionParserWrapper.new
      parser = wrapper.parse(args)

      if args.size == 0
        Commands::Help.run(parser)
        return
      end

      config = Config::Loader.from_yaml_file("config.yml")
      period = Models::Period.past(wrapper.days.days)
      sort_order = Models::SortOrder.from_string(wrapper.sort_order)
      printer = Printer.new(period, sort_order)

      case args[0]?
      when "public"
        Commands::Counter::Public.run(printer, config)
      when "private"
        Commands::Counter::Private.run(printer, config)
      else
        Commands::Help.run(parser)
      end
    end
  end
end
