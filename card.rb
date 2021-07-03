class Card
  attr_accessor :id, :title, :members, :labels, :due_date, :checklist

  @id_sequence = 0

  def initialize(card_properties)
    @id = card_properties[:id] || self.class.next_id
    @title = card_properties[:title]
    @members = card_properties[:members] || []
    @labels = card_properties[:labels] || []
    @due_date = card_properties[:due_date] || nil
    @checklist = card_properties[:checklist] || []
    keep_biggest_id
  end

  def update(data)
    @title = data[:title] unless data[:title].empty?
    @members = data[:members] unless data[:members].empty?
    @labels = data[:labels] unless data[:labels].empty?
    @due_date = data[:due_date] unless data[:due_date].empty?
  end

  def add_checklist(checklist)
    @checklist << checklist
  end

  def toggle_checklist(index)
    checklist = @checklist[index - 1]
    checklist[:completed] = !checklist[:completed]
  end

  def delete_checklist(index)
    @checklist.delete_at(index - 1)
  end

  def to_json(*_args)
    { id: @id, title: @title, members: @members, labels: @labels, due_date: @due_date, checklist: @checklist }.to_json
  end

  def self.next_id
    @id_sequence += 1
  end

  def self.sequence_val
    @id_sequence
  end

  def keep_biggest_id
    self.class.sequence = @id if @id > self.class.sequence_val
  end

  def self.sequence=(id)
    @id_sequence = id
  end
end
