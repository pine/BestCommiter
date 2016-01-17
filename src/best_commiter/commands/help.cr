require "option_parser"

module BestCommiter::Commands
  class Help
    parser :: OptionParser

    def self.run(parser : OptionParser)
      new(parser).run
    end

    protected def initialize(parser : OptionParser)
      @parser = parser
    end

    def run
      puts @parser
      puts
      self.exit
    end

    protected def exit
      ::exit
    end
  end
end
