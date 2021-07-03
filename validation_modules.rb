module Verify
  def verify_checklist(card_selected, index)
    return false if (index - 1).negative?

    card_selected.checklist[index - 1].nil? ? false : true
  end

  def verify_board(id)
    @store.find_board(id).nil? ? false : true
  end

  def verify_list(board_selected, id_or_list)
    board_selected.find_list_by_name(id_or_list).nil? ? false : true
  end

  def verify_card(board_selected, id)
    @store.find_list_given_card_id(board_selected, id).nil? ? false : true
  end
end

module Checklists
  def add_checklist(card_selected, _index)
    checklist_data = checklist_form
    return puts "\nTitle required!\n\n" if checklist_data[:title].empty?

    @store.add_checklist(card_selected, checklist_data)
  end

  def toggle_checklist(card_selected, index)
    return unless verify_checklist(card_selected, index)

    @store.toggle_checklist(card_selected, index)
  end

  def delete_checklist(card_selected, index)
    return unless verify_checklist(card_selected, index)

    @store.delete_checklist(card_selected, index)
  end
end
