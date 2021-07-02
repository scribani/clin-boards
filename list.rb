require_relative "card"

class List
  attr_reader :id, :name, :cards

  @id_secuence = 0

  def initialize(name)
    @id = self.class.next_id
    @name = name
    @cards = []
  end

  def update_list_name(new_name)
    @name = new_name
  end

  def create_card
    # call prompt
    data = { title: "Create Json" }
    # hard coded

    new_card = Card.new(data)
    @cards << new_card
  end

  def update_card
    # call prompt
    data = { card_id: 3, title: "terminal-table", members: ["Ana", "Andres"],
             labels: ["ivest", "reser"], due_date: "2020-11-19" }
    # hard coded

    card = find_card(data[:card_id])
    card.update(data)
  end

  def delete_card
    # call prompt
    card_id = 2
    # hard coded

    @cards.each_with_index do |card, index|
      @cards.delete_at(index) if card.id == card_id
    end
  end

  def card_show_checklist
    # call prompt
    id_card = 3
    # hard coded
    card = find_card(id_card)
    card.checklist
  end

  # def card_delete_checklist
  #   # call prompt
  #   prompt = { card_id: 3, idx_checklist: 0 }
  #   # hard coded
  #   card = find_card(prompt[:card_id])
  #   card.delete_checklist(prompt[:idx_checklist])
  # end

  # def card_add_checklist
  #   # call prompt
  #   prompt = { card_id: 3, title: "Make a check", completed: true }
  #   # hard coded

  #   data = { title: prompt[:title], completed: prompt[:completed] }
  #   card = find_card(prompt[:card_id])
  #   card.add_checklist(data)
  # end

  # def find_card(card_id)
  #   @cards.find { |card| card.id == card_id }
  # end

  def self.next_id
    @id_secuence += 1
  end

  def to_json(*_args)
    { id: @id, name: @name, cards: @cards }
  end
end
