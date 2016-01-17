require "option_parser"

module BestCommiter
  class OptionParserWrapper
    getter days :: Int32
    getter sort_order :: String
    getter version_flag :: Bool
    getter help_flag :: Bool

    def initialize
      @days = 7
      @sort_order = "name"
      @version_flag = false
      @help_flag = false
    end

    def parse(args : Array(String)) : OptionParser
      OptionParser.parse(args) do |parser|
        parser.banner = "
Usage:

  $ ./bin/best_commiter public --days 7
  Show Best OSS Commiter

  $ ./bin/best_commiter private --days 7
  Show Best Commiter
        "

        parser.on("-v", "--version", "Show version") do
          @version_flag = true
        end

        parser.on("-h", "--help", "Show help") do
          @help_flag = true
        end

        parser.on("-d DAYS", "--days DAYS", "Counting days") do |days|
          @days = days.to_i
        end

        parser.on("-s COLUMN", "--sort-by COLUM", "Sort by column (name or count)") do |sort_order|
          @sort_order = sort_order
        end
      end
    end
  end
end
