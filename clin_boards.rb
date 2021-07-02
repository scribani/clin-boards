require_relative "store"
require_relative "prompter"
# require_relative "formatter"
# require_relative "requester"

class ClinBoards
  include Prompter
  def initialize(store)
    @store = Store.new(store)
    @boards = @store.boards
  end

  def start
    # Complete this
    create_board
  end

  def create_board
    board_list = board_form
    board_new = Boards.new(board_list)
    @store.add_board(board_new)
  end
end

app = ClinBoards.new("store.json")
app.start
