require "../version"

module BestCommiter::Commands
  class Version
    def self.run
      new.run
    end

    protected def initialize
    end

    def run
      puts "v#{BestCommiter::VERSION}"
      self.exit
    end

    protected def exit
      ::exit
    end
  end
end
