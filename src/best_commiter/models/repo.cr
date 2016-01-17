module BestCommiter::Models
  class Repo
    getter name :: String
    getter count :: Int32

    def initialize(@name : String, @count : Int32)
    end
  end
end
