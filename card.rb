class Card
  attr_accessor :id, :title, :members, :labels, :due_date, :checklist

  @id_sequence = 0

  def initialize(title:, members: [], labels: [], due_date: nil)
    @id = self.class.next_id
    @title = title
    @members = members
    @labels = labels
    @due_date = due_date
    @checklist = []
  end

  def update(data)
    @title = data[:title] unless data[:title].empty?
    @members = data[:members] unless data[:members].empty?
    @labels = data[:labels] unless data[:labels].empty?
    @due_date = data[:due_date] unless data[:due_date].empty?
  end

  def add_checklist(data)
    @checklist << data
  end

  def delete_checklist(index)
    @checklist.delete_at(index)
  end

  def self.next_id
    @id_sequence += 1
  end

  def to_json(*_args)
    { id: @id, title: @title, members: @members, labels: @labels, due_date: @due_date }.to_json
  end
end
