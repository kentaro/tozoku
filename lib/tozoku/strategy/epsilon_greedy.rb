class Tozoku::Strategy::EpsilonGreedy
  attr_accessor :counts, :values, :epsilon

  def initialize(counts, values)
    @counts = connts
    @values = values
  end

  def select_arm(args)
    epsilon = args[:epsilon] || 0.1

    if rand > epsilon
      values.index(values.max)
    else
      rand(values.length)
    end
  end

  def update(chosen_arm, reward)
    count = counts[chosen_arm] += 1
    value = values[chosen_arm]

    values[chosen_arm] = ((count - 1)/count) * value +
                         (1/count) * reward
  end
end
