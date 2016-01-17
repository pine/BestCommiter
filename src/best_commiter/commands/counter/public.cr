require "./mixin"

module BestCommiter::Commands::Counter
  class Public
    include Mixin

    def self.run(*args)
      new(*args).run
    end

    def run
      counter = PublicCommitCounter.new(@github, @config.users)
      @printer.run(counter)
    end
  end
end
