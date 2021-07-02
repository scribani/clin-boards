class List
  attr_reader :id, :name, :cards

  @id_secuence = 0

  def initialize(name)
    @id = self.class.next_id
    @name = name
    @card = []
  end

  def self.next_id
    @id_secuence += 1
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

  def update_list_name(new_name)
    @name = new_name
  end

  def to_json(*_args)
    { id: @id, name: @name, cards: @cards }.to_json
  end
end
