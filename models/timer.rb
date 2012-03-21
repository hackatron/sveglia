class Timer
  attr_accessor :id, :name

  def initialize(hash={})
    @id = hash[:id]
    @name = hash[:name]
  end

  def self.all
    (1..100).map do |id|
      Timer.new(id: id, name: "Timer ##{id}")
    end
  end

  def to_hash
    {id: @id, name: @name}
  end

  def to_json
    JSON.generate(to_hash)
  end
end