require_relative "clin_boards"

puts [
  "####################################",
  "#      Welcome to CLIn Boards      #",
  "####################################"
]

app = ClinBoards.new
app.start

puts [
  "\n####################################",
  "#   Thanks for using CLIn Boards   #",
  "####################################\n\n"
]
