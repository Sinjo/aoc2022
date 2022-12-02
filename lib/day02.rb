require "pp"

class Day02
  MOVES = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors,
    "X" => :rock,
    "Y" => :paper,
    "Z" => :scissors,
  }

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
        game.map { |move| MOVES[move] }
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
