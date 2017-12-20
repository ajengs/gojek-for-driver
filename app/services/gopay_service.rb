class GopayService
  BASE_URI = 'http://localhost:8080/'
  # rest Rest::Client.new()

  def self.register_gopay(user)
    opts = set_params(user)
    response = HTTParty.post(BASE_URI, opts)
    puts response.body
    RequestResponse.json_to_hash(response.body)
  end

  def self.add(user, amount)
    opts = set_params(user, amount)
    response = HTTParty.put("#{BASE_URI}topup", opts)
    puts response.body
    RequestResponse.json_to_hash(response.body)
  end

  def self.substract(user, amount)
    opts = set_params(user, amount)
    response = HTTParty.put(BASE_URI, opts)
    puts response.body
    RequestResponse.json_to_hash(response.body)
  end

  def self.set_params(*params)
    {
      body: {
        id: params[0].id,
        type: 'driver',
        passphrase: params[0].password_digest,
        amount: params[1]
      }
    }
  end
end