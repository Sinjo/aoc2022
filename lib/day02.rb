require "pp"

class Day02
  MOVES_PART_A = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }

  MOVES_PART_B = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
  }

  GOALS_PART_B = {
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win,
  }

  MOVE_HIERARCHY = [:rock, :paper, :scissors]

  MOVE_SCORES = {
    rock: 1,
    paper: 2,
    scissors: 3,
  }

  def part_a(input)
    input.
      lines.
      map(&:chomp).
      map(&:split).
      map { |game|
        game.map { |move| MOVES_PART_A[move] }
      }.map { |game|
        score(game)
      }.sum
  end

  def part_b(input)
    input.
      lines.
      map(&:chomp).
      map(&:split).
      map { |game|
        [MOVES_PART_B[game.first], GOALS_PART_B[game.last]]
      }.map { |game|
        case game.last
        when :lose
          [game.first, MOVE_HIERARCHY[(MOVE_HIERARCHY.index(game.first) - 1) % 3]]
        when :draw
          [game.first, game.first]
        when :win
          [game.first, MOVE_HIERARCHY[(MOVE_HIERARCHY.index(game.first) + 1) % 3]]
        end
      }.map { |game|
        score(game)
      }.sum
  end

  private

  def score(game)
    their_move = game.first
    our_move = game.last

    game_score =
      if our_move == their_move
        3
      elsif beats?(game.last, game.first)
        6
      else
        0
      end


    MOVE_SCORES[our_move] + game_score
  end

  def beats?(our_move, their_move)
    [[:paper, :rock], [:rock, :scissors], [:scissors, :paper]].include?([our_move, their_move])
  end
end
