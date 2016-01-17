module BestCommiter
  class Printer
    def run(counter, config, github, before, after, sort_by, title = nil)
      results = counter.count(before, after)
      sorted_results = sort_results(results, sort_by)

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

    private def sort_results(results, sort_by)
      if sort_by == "count"
        return results.sort_by { |result|
          result.sum
        }.reverse
      end
      results.sort { |a, b| a.name <=> b.name }
    end
  end
end
