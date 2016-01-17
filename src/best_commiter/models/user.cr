require "./repo"

module BestCommiter::Models
  class User
    getter name :: String
    getter repos :: Array(Repo)

    def initialize(@name : String, @repos : Array(Repo))
    end

    def sum : Int32
      @sum ||= @repos.map { |repo| repo.count }.sum
    end
  end
end
