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
end
