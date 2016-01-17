module BestCommiter::Models
  enum SortOrder
    Name
    Count

    def self.from_string(sort_order : String) : SortOrder
      case sort_order
      when "name"
        SortOrder::Name
      when "count"
        SortOrder::Count
      else
        raise "Invalid `sort_order` string"
      end
    end
  end
end
