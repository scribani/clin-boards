# require_relative "formatter"
# require_relative "requester"

class ClinBoards
  def initialize(_store = "store.json")
    @store = "Store.new(store)" # HARDCODE!!!
    @board = "@store.boards" # HARDCODE!!!
  end

  def start
    action = ""
    until action == "exit"
      print "Enter action: "
      action, id = gets.chomp.split # HARDCODE!!!
      case action
      when "create" then puts "create_board" # HARDCODE!!!
      when "show" then puts "show_board(#{id})" # HARDCODE!!!
      when "update" then puts "update_board(#{id})" # HARDCODE!!!
      when "delete" then puts "remove_board(#{id})" # HARDCODE!!!
      when "exit" then goodbye
      else puts "Invalid option"
      end
    end
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
