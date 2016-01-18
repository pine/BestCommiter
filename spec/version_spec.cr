require "./spec_helper"
require "../src/best_commiter/version"

module BestCommiter
  it "VERSION" do
    BestCommiter::VERSION.should match(/\d+\.\d+\.\d+/)
  end
end
