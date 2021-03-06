require_relative "list"

class Boards
  attr_reader :id, :name, :description, :lists

  @id_sequence = 0

  def initialize(name:, description:, lists: [], id: nil)
    @id = id || self.class.next_id
    @name = name
    @description = description
    @lists = lists.empty? ? [] : lists.map { |list| List.new list }
    keep_biggest_id
  end

  def update(data)
    @name = data[:name] unless data[:name].empty?
    @description = data[:description] unless data[:description].empty?
  end

  def add_list(data)
    list = List.new(data)
    @lists << list
  end

  def delete_list(list_name)
    @lists.delete_if { |list| list.name == list_name }
  end

  def find_list_by_name(name)
    @lists.find { |list| list.name == name }
  end

  def to_json(*_args)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
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
