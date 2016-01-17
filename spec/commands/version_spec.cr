require "../spec_helper"
require "../../src/best_commiter/commands/version"

class SpyVersion < BestCommiter::Commands::Version
  getter! exit_called

  def initialize
    super
  end

  def exit
    @exit_called = true
  end
end

######################################################################

describe BestCommiter::Commands::Version do
  it "run" do
    version = SpyVersion.new
    version.run
    version.exit_called.should be_true
  end
end
