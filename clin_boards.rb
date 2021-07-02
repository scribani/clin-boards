require_relative "store"
require_relative "prompter"
require_relative "formatter"

class ClinBoards
  def initialize(_store = "store.json")
    @store = Store.new(store)
    @board = @store.boards
  end

  def start
    welcome
    action = ""
    until action == "exit"
      print "Enter action: " # HARDCODE!!!
      action, id = gets.chomp.split # HARDCODE!!!
      action_sym = "#{action}_board".to_sym

      return goodbye if action == "exit"

      methods.include?(action_sym) ? method(action_sym).call(id) : puts("Invalid option")
    end
  end

  def welcome
    puts [
      "####################################",
      "#      Welcome to CLIn Boards      #",
      "####################################"
    ]
  end

  def create_board(_id)
    board_list = board_form
    board_new = Boards.new(board_list)
    @store.add_board(board_new)
  end

  def show_board(id)
    # board_founded = method of @store.find...(id) of store's class
    print_lists # board_founded
    puts "show_board(#{id})" # HARDCODE!!!
  end

  def update_board(id)
    _board_updated = board_form
    # look for the store update in the store.rb @store.update_board(id, board_updated)
    puts "update_board(#{id})" # HARDCODE!!!
  end

  def delete_board(id)
    puts "delete_board(#{id})" # HARDCODE!!!
  end

  def goodbye
    puts [
      "\n####################################",
      "#   Thanks for using CLIn Boards   #",
      "####################################\n\n"
    ]
  end
end

app = ClinBoards.new
app.start
