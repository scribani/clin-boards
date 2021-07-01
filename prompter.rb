module Prompter
  def main_menu
    puts "Board options: create | show ID | update ID | delete ID\nexit"
    print "> "
    action, id = gets.chomp.split
    [action, id.to_i]
  end

  def list_menu
    puts "List options: create-list | update-list LISTNAME | delete-list LISTNAME"
    puts "Card options: create-card | checklist ID | update-card ID | delete-card ID\nback"
    print "> "
    action, id_list = gets.chomp.split
    [action, id_list]
  end

  def checklist_menu
    puts "Checklist options: add | toggle INDEX | delete INDEX\nback"
    print "> "
    action, id = gets.chomp.split
    [action, id.to_i]
  end

  def board_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp
    { name: name, description: description }
  end

  def checklist_form
    print "Title: "
    title = gets.chomp
    print "Card: "
    card = gets.chomp
    { card: card, title: title }
  end

  def list_form
    print "Name: "
    name = gets.chomp
    { name: name }
  end

  def card_form
    print "Select a list: "
    # puts imprimir la lista de listas map. or each
    list = gets.chomp
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp.split(",")
    print "Labels: "
    labels = gets.chomp
    print "Due Date: "
    due_date = gets.chomp
    { list: list, title: title, members: members, labels: labels, due_date: due_date }
  end
end
