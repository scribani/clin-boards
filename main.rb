require_relative "clin_boards"

puts [
  "\n####################################",
  "#      Welcome to CLIn Boards      #",
  "####################################\n\n"
]

app = ClinBoards.new
app.start

puts [
  "\n####################################",
  "#   Thanks for using CLIn Boards   #",
  "####################################\n\n"
]
