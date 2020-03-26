module Score

  def Score.calculate(dice)
    non_scoring_dice = to_values_count(dice - [1, 5])
    scoring_dice     = {1 => dice.count(1), 5 => dice.count(5)}

    score = [0, 100, 200, 1000, 1100, 1200][scoring_dice[1]]
    score += [0, 50, 100, 500, 550, 600][scoring_dice[5]]

    [2,3,4,6].each do |num|
        if dice.count(num) >= 3 then
          score += num * 100
          scoring_dice[num]      = 3
          non_scoring_dice[num] -= 3
        end
    end
    yield to_dice(scoring_dice), to_dice(non_scoring_dice) if block_given?
    score
  end

  def Score.to_values_count(dice)
    dice.reduce(Hash.new(0)) {|values, die| values[die] += 1; values}
  end

  def Score.to_dice(values_count)
    values_count.map {|value, count| Array.new(count, value)}.flatten
  end
end
