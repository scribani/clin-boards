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

      return if action == "exit"

      methods.include?(action_sym) ? method(action_sym).call(id) : puts("Invalid option")
    end
  end

  def create_board(_id)
    board_data = board_form
    board_new = Boards.new(board_data)
    @store.add_board(board_new)
  end

  def update_board(id)
    board_data = board_form
    @store.update_board(id, board_data)
  end

  def delete_board(id)
    @store.delete_board(id)
  end

  # From here we have methods that are used in lists view
  def show_board(id)
    board_selected = @store.find_board(id)

    action = ""
    until action == "back"
      print_lists(board_selected)
      action, id_or_list = list_menu # second value could be ID or LISTNAME
      action_sym = action.to_sym

      return start if action == "back"

      methods.include?(action_sym) ? method(action_sym).call(board_selected, id_or_list) : puts("Invalid option")
    end
  end

  def create_list(board_selected, _id_or_list)
    list_data = list_form
    @store.add_list(board_selected, list_data)
  end

  def update_list(board_selected, id_or_list)
    list_name = id_or_list
    @store.update_list(board_selected, list_name)
  end

  def delete_list(board_selected, id_or_list)
    list_name = id_or_list
    @store.delete_list(board_selected, list_name)
  end

  def create_card(board_selected, _id_or_list)
    options = print_lists_names(board_selected)
    puts options
    options = options.split(" | ")
    list_name = list_selection_form(options)
    list = @store.find_list_by_name(board_selected, list_name)
    card_data = card_form
    @store.add_card(list, card_data)
  end

  def update_card(board_selected, id_or_list)
    id = id_or_list.to_i
    card_data = card_form
    @store.update_card(board_selected, id, card_data)
  end

  def delete_card(board_selected, id_or_list)
    id = id_or_list.to_i
    @store.delete_card(board_selected, id)
  end

  # From here we have methods that are used in card_checklist view
  def checklist(board_selected, id_or_list)
    id = id_or_list.to_i
    list_selected = @store.find_list_given_card_id(board_selected, id)
    card_selected = @store.find_card(list_selected, id)

    action = ""
    until action == "back"
      print_card_checklist(card_selected)
      action, index = checklist_menu
      action_sym = "#{action}_checklist".to_sym

      return show_board(board_selected.id) if action == "back"

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
