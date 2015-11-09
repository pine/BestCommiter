require "github_simple"
require "../github"

module BestComitter
  class PublicCommitCounter
    include GitHub::EventType

    def initialize(@config, @github)
    end

    def count(before, after)
      users = @config.users || [] of String
      repo_names = users.map { |user| repo_names_by_user(user) }.flatten.uniq.sort
      commits = repo_names.map { |name| commits_by_repo_name(name, before, after) }.flatten
      users.map { |user| {user, count_by_commits(user, commits)} }.to_h
    end

    def repo_names_by_user(user)
      puts "Fetch #{user}'s events"

      events = @github.users(user).events(public: true)
      printf "> Found %3d events\n", events.size

      repo_names = events.map { |event|
        case event.type
        when PUSH_EVENT, ISSUES_EVENT, PULL_REQUEST_EVENT
          event.repo.name
        end
      }.compact.uniq

      printf "> Found %3d repositories\n\n", repo_names.size
      repo_names
    end

    def commits_by_repo_name(name, before, after)
      puts "Fetch #{name} commits"

      owner, repo = name.split("/")
      format = Time::Format.new("%Y-%m-%dT%H:%M:%S%z")
      before = format.format(before)
      after = format.format(after)

      commits = @github.repos(owner, repo).commits({"since": before, "until": after})
      printf "> Found %3d commits\n\n", commits.size

      commits.map { |commit| {name, commit} }
    end

    def count_by_commits(user_name, commits)
      puts "Counting #{user_name}'s commits"

      commits_count = 0
      filtered_repos = {} of String => Int32

      commits.each do |commit|
        if author = commit[1].author
          if user_name == author.login
            repo_name = commit[0]
            commits_count += 1
            filtered_repos[repo_name] = filtered_repos.fetch(repo_name, 0) + 1
          end
        end
      end

      printf "> Found %3d commits\n\n", commits_count
      filtered_repos
    end
  end
end
