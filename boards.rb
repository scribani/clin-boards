class Boards
  attr_reader :id, :name, :description, :lists

  @id_sequence = 0

  def initialize(name:, description:, id: nil)
    @id = id || self.class.next_id
    @name = name
    @description = description
    @lists = lists.map { |list| List.new list }
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

  def to_json(*_args)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
  end

  def self.sequence=(id)
    @id_sequence = id
  end

  def self.next_id
    @id_sequence += 1
  end
end
