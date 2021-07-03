require_relative "clin_boards"

filename = ARGV.empty? ? "store.json" : ARGV.shift

puts [
  "\n####################################",
  "#      Welcome to CLIn Boards      #",
  "####################################\n\n"
]

flag = File.exist?(filename) ? "r+" : "w+"
file = File.open(filename, flag)

app = ClinBoards.new(filename)
app.start

file.close

puts [
  "\n####################################",
  "#   Thanks for using CLIn Boards   #",
  "####################################\n\n"
]
