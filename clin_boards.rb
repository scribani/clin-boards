require_relative "store"
require_relative "prompter"
require_relative "formatter"

class ClinBoards
  def initialize(_store = "store.json")
    @store = Store.new(store)
    @board = @store.boards
  end

  def start
    action = ""
    until action == "exit"
      print "Enter action: " # HARDCODE!!!
      action, id = gets.chomp.split # HARDCODE!!!
      action_sym = "#{action}_board".to_sym

      return goodbye if action == "exit"

      methods.include?(action_sym) ? method(action_sym).call(id) : puts("Invalid option")
    end
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
      action, _item = list_menu
      case action
      when "create-list" then puts "create-list " # HC!
      when "update-list LISTNAME" then puts "update " # HC!
      when "delete-list LISTNAME" then puts "delete " # HC!
      when "create-card" then puts " create-card checklist ID update-card ID" # HC!
      end
    end
  end

  def update_board(id)
    board_updated = board_form
    @store.update_board(id, board_updated)
    puts "update_board(#{id})" # HARDCODE!!!
  end

  def delete_board(id)
    @store.delete_board(id)
  end

  def show_lists(id)
    board_selected = @store.find_board(id)

    action = ""
    until action == "back"
      print_lists(board_selected)
      action, id_or_list = list_menu # second value could be ID or LISTNAME
      action_sym = "#{action}_list".to_sym

      methods.include?(action_sym) ? method(action_sym).call(board_selected, id_or_list) : puts("Invalid option")
    end
  end
end

app = ClinBoards.new
app.start
