module RequestResponse
  def self.json_to_hash(response)
    JSON.parse(response.body).symbolize_keys
  end
  def json_to_hash(response)
    JSON.parse(response.body).symbolize_keys
  end
end