class Timer < RedisRecord
  def self.all
    (1..100).map do |id|
      Timer.new(id: id, name: "Timer ##{id}")
    end
  end

  def self.find(id)
    Timer.new(id: id, name: "Timer ##{id}")
  end
end