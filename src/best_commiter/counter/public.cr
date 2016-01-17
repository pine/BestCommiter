require "github_simple"

require "../github"
require "./base"
require "../models/user"

module BestCommiter::Counter
  class PublicCommitCounter < Base
    def initialize(github, @user_names)
      super(github)
    end

    def title
      "Best OSS Commiter"
    end

    def run(period : Models::Period)
      repo_names = @user_names.map { |user| repo_names_by_user(user) }.flatten.uniq.sort
      commits = repo_names.map { |name| commits_by_repo_name(name, period) }.flatten
      @user_names.map { |user| Models::User.new(user, count_by_commits(user, commits)) }
    end
  end
end
