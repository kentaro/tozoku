require 'tozoku/version'

class Tozoku
  attr_reader :strategy

  def initialize(strategy, arms)
    file_name = file_name_for(strategy)
    require   = file_name

    @strategy = strategy_class_for(strategy).new(arms)
  end

  def select_arm(args)
    @strategy.select_arm(args)
  end

  def update(chosen_arm, reward)
    @strategy.update(chosen_arm, reward)
  end

  def strategy_class_for(strategy)
    Kernel.const_get(self.class.to_s).const_get('Strategy').const_get(strategy.to_s)
  end

  def file_name_for(strategy)
    file_name = strategy.to_s.gsub(/[A-Z][a-z0-9_]+?/) { |s| "_#{s.downcase}" }
    'tozoku/strategy/' + file_name.sub(/^_/, '')
  end
end
