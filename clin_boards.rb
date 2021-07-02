require_relative "store"
require_relative "prompter"
require_relative "formatter"

class ClinBoards
  def initialize(_store = "store.json")
    @store = Store.new(store)
    @board = @store.boards
  end

  # From here we have methods that are used in boards view
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
    puts "show_board(#{id})" # HARDCODE!!!
  end

  def update_board(id)
    puts "update_board(#{id})" # HARDCODE!!!
  end

  def delete_board(id)
    puts "delete_board(#{id})" # HARDCODE!!!
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

  def add_checklist(_card_selected, _index)
    checklist_data = checklist_form
    @store.add_checklist(checklist_data)
  end

  def toggle_checklist(card_selected, index)
    @store.toggle_checklist(card_selected, index)
  end

  def delete_checklist(card_selected, index)
    @store.delete_checklist(card_selected, index)
  end
end
