require_relative "store"
require_relative "prompter"
require_relative "formatter"

class ClinBoards
  include Formatter
  include Prompter

  def initialize(store = "store.json")
    @store = Store.new(store)
    @boards = @store.boards
  end

  # From here we have methods that are used in boards view
  def start
    action = ""
    until action == "exit"
      print_boards
      action, id = main_menu
      action_sym = "#{action}_board".to_sym

      return goodbye if action == "exit"

      methods.include?(action_sym) ? method(action_sym).call(id) : puts("Invalid option")
    end
  end

  def create_board(_id)
    board_data = board_form
    board_new = Boards.new(board_data)
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

  # From here we have methods that are used in card_checklist view
  def show_card_checklist(id)
    card_selected = @store.find_card(id)

    action = ""
    until action == "back"
      print_card_checklist(card_selected)
      action, index = checklist_menu
      action_sym = "#{action}_checklist".to_sym

      methods.include?(action_sym) ? method(action_sym).call(card_selected, index) : puts("Invalid option")
    end
  end

  def add_checklist(card_selected, _index)
    checklist_data = checklist_form
    @store.add_checklist(card_selected, checklist_data)
  end

  def toggle_checklist(card_selected, index)
    @store.toggle_checklist(card_selected, index)
  end

  def delete_checklist(card_selected, index)
    @store.delete_checklist(card_selected, index)
  end
end
