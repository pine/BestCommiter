module BestCommiter::Models
  class Period
    getter before :: Time
    getter after :: Time

    def initialize(@before : Time, @after : Time)
    end

    def self.past(span : Time::Span)
      after = Time.now
      before = after - span
      new(before, after)
    end
  end
end
