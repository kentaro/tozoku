require 'tozoku/version'
require 'tozoku/strategy/epsilon_greedy'

class Tozoku
  STRATEGIES = %w(EpsilonGreedy)

  attr_reader :arm_count, :counts, :values, :strategies

  def initialize(arm_count, counts = nil, values = nil)
    @arm_count  = arm_count
    @counts     = counts || arm_count.map { |i| 0   }
    @values     = values || arm_count.map { |i| 0.0 }
    @strategies = STRATEGIES.each_with_object({}) do |name, strategies|
      klass = class_constant_from(name)
      strategies[strategy_name] = klass.new(
        counts.dup,
        values.dup,
      )
    end
  end

  def select_arm(args)
    strategy_name = args[:with] || 'EpsilonGreedy'
    strategy_args = args[:args] || {}
    strategy      = strategies[strategy_name]

    strategy.select_arm(args)
  end

  def update(chosen_arm, reward)
    strategies.values.each do |strategy|
      strategy.update(chosen_arm, reward)
    end
  end

  def class_constant_from(strategy)
    Kernel.const_get(self.class.to_s).const_get('Strategy').const_get(strategy)
  end
end
