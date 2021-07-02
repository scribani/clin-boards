require "json"
require_relative "boards"
require_relative "prompter"

class Store
  attr_accessor :boards

  include Prompter

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

  def add_list(board, data)
    board.add_list(data)
    persist_json
  end

  def find_list(board, id)
    board.lists.find { |list| list.id == id }
  end

  def update_list(board, list_name)
    found_list = board.lists.find { |list| list.name == list_name }
    new_name = list_form
    found_list.update_list_name(new_name)
    persist_json
  end

  def delete_list(board, list_name)
    board.delete_list(list_name)
    persist_json
  end

  def add_card(list, data)
    list.create_card(data)
    persist_json
  end

  def update_card(id, data)
    list_found = find_list_given_card_id(id)
    found_card = find_card(list_found, id)
    found_card.update(data)
    persist_json
  end

  def delete_card(id)
    list_found = find_list_given_card_id(id)
    list_found.delete_card(id)
    persist_json
  end

  def persist_json
    File.write(@filename, @boards.to_json)
  end

  def find_list_given_card_id(card_id)
    @boards.lists.find do |list|
      list.cards.find { |card| card.id == card_id }
    end
  end

  def find_card(list, card_id)
    list.cards.find { |card| card.id == card_id }
  end

  def add_checklist(card, checklist)
    card.add_checklist(checklist)
    persist_json
  end

  def toggle_checklist(card, index)
    card.toggle_checklist(index)
    persist_json
  end

  def delete_checklist(card, index)
    card.delete_checklist(index)
    persist_json
  end
end
