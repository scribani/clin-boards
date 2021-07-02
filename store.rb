require "json"
require_relative "boards"

class Store
  attr_accessor :boards

  def initialize(filename)
    @filename = filename
    @boards = load_boards
  end

  def load_boards
    JSON.parse(File.read(@filename), { symbolize_names: true }).map do |board|
      Boards.new(board)
    end
  end

  def add_board(board)
    @boards << board
    persist_json
  end

  def find_board(id)
    @boards.find { |board| board.id == id }
  end

  def update_board(id, data)
    found_board = find_board(id)
    found_board.update(data)
    persist_json
  end

  def delete_board(id)
    @boards.delete_if { |board| board.id == id }
    persist_json
  end

  def add_list(board, list)
    board.lists << list
    persist_json
  end

  def find_list(board, id)
    board.lists.find { |list| list.id == id }
  end

  def update_list(board, id, data)
    found_list = find_list(board, id)
    found_list.update(data)
    persist_json
  end

  def delete_list(board, id)
    board.lists.delete_if { |list| list.id == id }
    persist_json
  end

  def add_card(list, card)
    list.cards << card
    persist_json
  end

  def update_card(id, data)
    list_found = find_list_given_card_id(id)
    found_card = find_card(list_found, id)
    found_card.update(data)
    persist_json
  end

  def delete_card(id)
    list = find_list_given_card_id(id)
    list.cards.delete_if { |card| card.id == id }
    persist_json
  end

  def persist_json
    File.write(@filename, @boards.to_json)
  end

  def find_list_given_card_id(card_id)
    @boards.lists.select do |list|
      list.cards.find { |card| card.id == card_id }
    end
  end

  def find_card(list, card_id)
    list.cards.find { |card| card.id == card_id }
  end

  def add_checklist(card, checklist)
    card.checklist << checklist
    persist_json
  end

  def toggle_checklist(card, index)
    checklist = card.checklist[index]
    checklist[:completed] = !checklist[:completed]
    persist_json
  end

  def delete_checklist(card, index)
    card.checklist.delete_at(index - 1)
    persist_json
  end
end
