require "github_simple"

require "../../counter/*"
require "../../models/period"
require "../../printer"

module BestCommiter::Commands::Counter
  module Mixin
    github :: GitHub::Simple::Client

    protected def initialize(
      @printer : Printer,
      @config : Config::Root
    )
      @github = GitHub::Simple::Client.new(
        access_token: @config.github.access_token,
        auto_paginate: true
      )
    end
  end
end
