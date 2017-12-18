class GopayService
  BASE_URI = 'http://localhost:8080/'
  # rest Rest::Client.new()

  def self.register_gopay(user)
    # opts =  {
    #   body: {
    #     id: params[:id],
    #     type: params[:type],
    #     passphrase: params[:passphrase]
    #   }
    # }
    puts "posting #{user.first_name}"
    opts = {
      body: {
        id: user.id,
        type: 'driver',
        passphrase: user.password_digest
      }
    }
    response = HTTParty.post(BASE_URI, opts)
    puts response.body
    RequestResponse.json_to_hash(response)
  end

  def self.topup(user, amount)
    puts "patch top up"
    opts = {
      body: {
        id: user.id,
        type: 'driver',
        passphrase: user.password_digest,
        amount: amount
      }
    }
    response = HTTParty.put("#{BASE_URI}topup", opts)
    puts response.body
    res = RequestResponse.json_to_hash(response)
    if res[:Status] == 'OK'
      user.update(gopay: res[:Account]["Amount"])
    end
    res
  end

  def self.use(user, amount)
    puts "patch use gopay"
    opts = {
      body: {
        id: user.id,
        type: 'driver',
        passphrase: user.password_digest,
        amount: amount
      }
    }
    response = HTTParty.put(BASE_URI, opts)
    puts response.body
    res = RequestResponse.json_to_hash(response)
    if res[:Status] == 'OK'
      user.update(gopay: res[:Account]["Amount"])
    end
    res
  end

end