require "option_parser"

require "./version"
require "./config"
require "./counter/*"
require "./commands/*"
require "./models/*"
require "./printer"

module BestCommiter
  class CLI
    def initialize
    end

    def run(args)
      begin
        run_with_args(args)
      rescue OptionParser::MissingOption
        puts "Missing arguments"
      end
    end

    private def run_with_args(args)
      days = 7
      sort_by = "name"

      parser = OptionParser.parse(args) do |parser|
        parser.banner = "
Usage:

  $ ./bin/best_commiter public --days 7
  Show Best OSS Commiter

  $ ./bin/best_commiter private --days 7
  Show Best Commiter
        "
        parser.on("-v", "--version", "Show version") { Commands::Version.run }
        parser.on("-h", "--help", "Show help") { Commands::Help.run(parser) }
        parser.on("-d DAYS", "--days DAYS", "Counting days") { |x| days = x.to_i }
        parser.on("-s COLUMN", "--sort-by COLUM", "Sort by column (name or count)") { |x| sort_by = x }
      end

      if args.size == 0
        Commands::Help.run(parser)
        return
      end

      config = load_config
      after = Time.now
      before = after - days.days
      github = GitHub::Simple::Client.new(
        access_token: config.github.access_token,
        auto_paginate: true
      )

      case args[0]?
      when "public"
        counter = PublicCommitCounter.new(config, github)
        title = "Best OSS Commiter"
        show_count(counter, config, github, before, after, sort_by, title)
      when "private"
        counter = PrivateCommitCounter.new(config, github)
        title = "Best Commiter"
        show_count(counter, config, github, before, after, sort_by, title)
      else
        Commands::Help.run(parser)
      end
    end

    def show_count(counter, config, github, before, after, sort_by, title = nil)
      Printer.new.run(counter, config, github, before, after, sort_by, title)
    end

    private def load_config
      Config::Loader.from_yaml_file("config.yml")
    end
  end
end
