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
    board_founded = @store.find_board(id)
    action = "" 
    until action == "back"
      print_lists board_founded
      action, id_list = list_menu
      case action
        when "create-list" then puts "show_board - create-list(#{id_list.to_i})" # HARDCODE!!!
        when "update-list LISTNAME" then puts "show_board - update-list(#{id_list})" # HARDCODE!!!
        when "delete-list LISTNAME" then puts "show_board - delete - list(#{id_list})" # HARDCODE!!!
        when "create-card" then puts "show_board(#{id_list.to_i}) - create-card" # HARDCODE!!!
        when "checklist ID" then puts "show_board(#{id_list.to_i}) - check-list id" # HARDCODE!!!
        when "update-card ID" then puts "show_board(#{id_list.to_i}) update card id" # HARDCODE!!!
        when "delete-card ID" then puts "show_board(#{id_list.to_i}) delete card id" # HARDCODE!!!
      end
    end
    puts "show_board(#{id})" # HARDCODE!!!
  end
  
  def update_board(id)
    board_updated = board_form
    @store.update_board(id, board_updated)
    puts "update_board(#{id})" # HARDCODE!!!
  end

  def delete_board(id)
    @store.delete_board(id)
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
