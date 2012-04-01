# A simple wrapper to Redis objects
class RedisRecord
  def initialize(attributes={})
    @attributes = symbolize_keys!(attributes)
    @attributes.merge!(:id => generate_token) unless @attributes[:id]
    define_attribute_methods(@attributes)
  end

  def generate_token
    Digest::SHA1.hexdigest(rand(36**32).to_s(36))
  end

  def to_hash
    @attributes
  end

  def to_json
    JSON.generate(to_hash)
  end

  def define_attribute_methods(attributes)
    attributes.each do |key, value|
      self.class.send(:define_method, key, proc { @attributes[key] })
      self.class.send(:define_method, "#{key}=", proc{ |value| @attributes[key] = value })
    end
  end

  def symbolize_keys!(hash)
    hash.keys.each do |key|
      hash[(key.to_sym rescue key) || key] = hash.delete(key)
    end
    hash
  end
end