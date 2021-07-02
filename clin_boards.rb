# require_relative "formatter"
# require_relative "requester"

class ClinBoards
  def initialize(_store = "store.json")
    @store = "Store.new(store)" # HARDCODE!!!
    @board = "@store.boards" # HARDCODE!!!
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
    puts "create_board" # HARDCODE!!!
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
