require "option_parser"

require "../spec_helper"
require "../../src/best_commiter/commands/help"

class SpyOptionParser < OptionParser
  getter! to_s_called :: Bool

  def initialize
    super
  end

  def to_s(io : IO)
    @to_s_called = true
    ""
  end
end

class SpyHelp < BestCommiter::Commands::Help
  getter! exit_called :: Bool

  def initialize(parser : OptionParser)
    super(parser)
  end

  def exit
    @exit_called = true
  end
end

######################################################################

describe BestCommiter::Commands::Help do
  it "run" do
    parser = SpyOptionParser.new
    help = SpyHelp.new(parser)

    help.run

    (parser as SpyOptionParser).to_s_called.should be_true
    help.exit_called.should be_true
  end
end
