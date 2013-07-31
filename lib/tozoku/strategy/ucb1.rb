class Tozoku::Strategy::UCB1 < Tozoku::Strategy
  def select_arm(args = {})
    # Returns an arm if there's one that has not been selected yet
    if arm = arms.find { |a| a['count'] == 0 }
      return arm
    end

    ucb_values  = []
    total_count = arms.inject(0) { |r, i| r += i['count'] }

    arms.each do |a|
      bonus = Math.sqrt((2 * Math.log(total_count)) / a['count'].to_f)
      ucb_values.push(a['value'] + bonus)
    end

    index = ucb_values.index(ucb_values.max)
    arms[index]
  end

  def update(arm, reward)
    chosen = arms.find { |a| a['name'] == arm }
    count  = chosen['count'] += 1
    value  = chosen['value']

    chosen['value'] = ((count - 1) / count) * value +
                      (1 / count) * reward
  end
end
