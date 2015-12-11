require "github_simple"
require "../github"
require "./mixin"

module BestCommiter
  class PublicCommitCounter
    include GitHub::EventType
    include CounterUtils

    def initialize(@config, @github)
    end

    def count(before, after)
      users = @config.users || [] of String
      repo_names = users.map { |user| repo_names_by_user(user) }.flatten.uniq.sort
      commits = repo_names.map { |name| commits_by_repo_name(name, before, after) }.flatten
      users.map { |user| {user, count_by_commits(user, commits)} }
    end

    protected def repo_names_by_user(user)
      repo_names_by_user(@github, user)
    end

    protected def commits_by_repo_name(name, before, after)
      commits_by_repo_name(@github, name, before, after)
    end
  end
end
