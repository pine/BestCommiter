require "./models/period"

module BestCommiter
  class Printer
    def initialize(@period : Models::Period, @sort_order : Models::SortOrder)
    end

    def run(counter)
      title = counter.title
      before = @period.before
      after = @period.after
      results = counter.count(@period.before, @period.after)
      sorted_results = sort_users(results)

      puts

      if title
        puts title
        puts
      end

      puts "FROM: #{before}"
      puts "TO  : #{after}"
      puts

      sorted_results.each do |result|
        username = result.name
        count = result.sum

        if count > 0
          puts "#{username}: #{count}"
          result.repos.each { |repo| puts " - #{repo.name}: #{repo.count}" }
          puts
        end
      end
    end

    private def sort_users(users : Array(Models::User)) : Array(Models::User)
      case @sort_order
      when Models::SortOrder::Name
        users.sort { |a, b| a.name <=> b.name }
      when Models::SortOrder::Count
        users.sort_by { |user| user.sum }.reverse
      else
        [] of Models::User
      end
    end
  end
end
