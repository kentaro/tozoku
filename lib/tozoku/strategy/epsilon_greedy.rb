class Tozoku
  module Strategy
    class EpsilonGreedy
      attr_reader :arms

      def initialize(arms)
        @arms = arms
      end

      def select_arm(args = {})
        epsilon = args[:epsilon] || 0.1
        values  = arms.map { |a| a['value'] }
        index   = if rand > epsilon
                    values.index(values.max)
                  else
                    rand(values.length)
                  end

        arms[index]
      end

      def update(arm, reward)
        chosen = arms.first { |a| a['name'] == arm }
        count  = chosen['count'] += 1

        chosen['value'] = ((count - 1)/count) * chosen['value'] + (1/count) * reward
      end
    end
  end
end
