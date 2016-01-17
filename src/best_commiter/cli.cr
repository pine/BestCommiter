require "option_parser"

require "./version"
require "./config"
require "./counter/*"
require "./commands/*"

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
      results = counter.count(before, after)
      sorted_results = sort_results(results, sort_by)

      puts

      if title
        puts title
        puts
      end

      puts "FROM: #{before}"
      puts "TO  : #{after}"
      puts

      sorted_results.each do |result|
        username = result[0]
        counts = result[1]
        count = counts.map { |k, v| v }.sum

        if count > 0
          puts "#{username}: #{count}"
          counts.each { |k, v| puts " - #{k}: #{v}" }
          puts
        end
      end
    end

    private def load_config
      Config::Loader.from_yaml_file("config.yml")
    end

    private def sort_results(results, sort_by)
      if sort_by == "count"
        return results.sort_by { |result|
          result[1].values.sum
        }.reverse
      end
      results.sort { |a, b| a[0] <=> b[0] }
    end
  end
end
