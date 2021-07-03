require_relative "card"

class List
  attr_reader :id, :name, :cards

  @id_sequence = 0

  def initialize(name:, cards: [], id: nil)
    @id = id || self.class.next_id
    @name = name
    @cards = cards.empty? ? [] : cards.map { |card| Card.new card }
    keep_biggest_id
  end

  def create_card(data)
    new_card = Card.new(data)
    @cards << new_card
  end

  def delete_card(id)
    @cards.each_with_index do |card, index|
      @cards.delete_at(index) if card.id == id
    end
  end

  def update_list_name(name:)
    @name = name
  end

  def to_json(*_args)
    { id: @id, name: @name, cards: @cards }.to_json
  end

  def self.next_id
    @id_sequence += 1
  end

  def self.sequence_val
    @id_sequence
  end

  def keep_biggest_id
    self.class.sequence = @id if @id > self.class.sequence_val
  end

  def self.sequence=(id)
    @id_sequence = id
  end
end
