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

  def update_board(id, data)
    found = find_board(id)
    found.update(data)
    persist_json
  end

  def delete_board(id)
    @boards.delete_if { |board| board.id == id }
    persist_json
  end

  def persist_json
    File.write(@filename, @playlists.to_json)
  end
end
