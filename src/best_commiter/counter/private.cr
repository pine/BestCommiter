require "github_simple"

require "./base"
require "../github"
require "../models/user"
require "../models/period"

module BestCommiter::Counter
  class PrivateCommitCounter < Base
    def initialize(github, @user_names, @repo_names)
      super(github)
    end

    def title
      "Best Commiter"
    end

    def run(period : Models::Period)
      commits = @repo_names.map { |name| commits_by_repo_name(name, period) }.flatten
      @user_names.map { |user| Models::User.new(user, count_by_commits(user, commits)) }
    end
  end
end
