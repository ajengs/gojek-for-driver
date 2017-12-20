class CustomerApi
  BASE_URI = 'http://localhost:3000/api/v1/'

  def self.send_check_request(user)
    opts = {
      body: {
        email: user.email,
        phone: user.phone
      }
    }
    response = HTTParty.post("#{BASE_URI}check_user", opts)
    RequestResponse.json_to_hash(response.body)
  end
end
