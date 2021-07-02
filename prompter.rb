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
    action, *id_or_list = gets.chomp.split
    action.sub!("-", "_") if action.include?("-")
    [action, id_or_list.join(" ")]
  end

  def checklist_menu
    puts "Checklist options: add | toggle INDEX | delete INDEX\nback"
    print "> "
    action, index = gets.chomp.split
    [action, index.to_i]
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
    { title: title, completed: false }
  end

  def list_form
    print "Name: "
    name = gets.chomp
    { name: name }
  end

  def card_form
    print "Title: "
    title = gets.chomp
    print "Members: "
    members = gets.chomp.split(", ")
    print "Labels: "
    labels = gets.chomp
    print "Due Date: "
    due_date = gets.chomp
    { title: title, members: members, labels: labels, due_date: due_date }
  end

  def list_selection_form(options)
    list = ""
    until options.include?(list)
      print "Select a list: "
      list = gets.chomp.downcase
    end
    list
  end
end
