class Occurrence

  class Predicate
    def match(date)
      return true
    end

    # from_date is not yielded if match
    def each(from_date, limit)
      d = from_date
      limit.times do
        d = next_match(d)
        yield d
      end
    end

    def next_match(d)
      return d if match(d) while (d = d.next)
    end

    class Or < Predicate
      def initialize(*predicates)
        @predicates = predicates
      end

      def match(date)
        @predicates.find {|p| p.match(date) }
      end
    end
    def |(other)
      Or.new(self, other)
    end

    class DayOfWeek < Predicate
      def initialize(dow)
        @dow = dow
      end

      def match(date)
        date.wday == @dow
      end

      def next_match(date)
        ((date.wday + 6) % 7 < @dow ? date.monday : date.next_week) + @dow
      end
    end
    %w{monday tuesday wednesday thursday friday saturday sunday}.each_with_index do |dow, i|
      define_method dow do
        DayOfWeek.new(i)
      end
    end


    class LastInMonth < Predicate
      def initialize(p)
        @predicate = p
      end

      def match(date)
        @predicate.match(date) && (@predicate.next_match(date).beginning_of_month > date.beginning_of_month)
      end
    end
    def last_in_month
      LastInMonth.new(self)
    end

  end

  def self.every
    Predicate.new
  end
end
