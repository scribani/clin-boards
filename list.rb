class List
  attr_reader :id, :name, :cards

  @id_secuence = 0

  def initialize(name)
    @id = self.class.next_id
    @name = name
    @card = []
  end

  def self.next_id
    @id_secuence += 1
  end

  def update_list_name(new_name)
    @name = new_name
  end

  def self.next_id
    @id_secuence += 1
  end

  def to_json(*_args)
    { id: @id, name: @name, cards: @cards }.to_json
  end
end
