class RequestResponse
  def self.json_to_hash(response)
    hash_response = JSON.parse(response).symbolize_keys
    deep_symbolize_keys(hash_response)
  end

  def self.deep_symbolize_keys(hsh)
    hsh.symbolize_keys!
    hsh.each do |k, v|
      if v.is_a?(Hash)
        v.symbolize_keys!
        deep_symbolize_keys(v)
      end
    end
  end
end