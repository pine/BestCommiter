require "./mixin"

module BestCommiter::Commands::Counter
  class Private
    include Mixin

    def self.run(*args)
      new(*args).run
    end

    def run
      counter = Counter::PrivateCommitCounter.new(@github, @config.users, @config.repos)
      @printer.run(counter)
    end
  end
end
