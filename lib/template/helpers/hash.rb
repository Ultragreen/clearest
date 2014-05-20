class Hash
  def symbolize!
    self.keys.each do |key|
      self[key.to_sym] = self.delete(key)
    end
    return ahash
  end
  
end
