class Allocation
  attr_reader :origin_point

  def initialize(params)
    @order_id = params["id"]
    @origin_point = [params["origin_latitude"], params["origin_longitude"]]
  end

  def radius
    1
  end

  def boundary
    Geocoder::Calculations.bounding_box(@origin_point, radius, { units: :km })
  end

  def allocate_driver
    boundary_box = boundary
    users = User.where("latitude BETWEEN :southeast_latitude AND :northwest_latitude AND
      longitude BETWEEN :southeast_longitude AND :northwest_longitude",
      southeast_latitude: boundary_box[0],
      southeast_longitude: boundary_box[1],
      northwest_latitude: boundary_box[2],
      northwest_longitude: boundary_box[3]
    )

    allocations = []
    users.each do |user|
      allocations << {
        order_id: @order_id, 
        user: user, 
        distance: 
          Geocoder::Calculations.distance_between(@origin_point, [user.latitude, user.longitude], {units: :km})
      }
    end

    #TODO allocate by orders count
    #TODO push notification
    allocations.min_by { |a| a[:distance] }

    #TODO create order for this driver, send driver details
  end

  def produce_allocated
      config = {
                :"bootstrap.servers" => 'velomobile-01.srvs.cloudkafka.com:9094,velomobile-02.srvs.cloudkafka.com:9094,velomobile-03.srvs.cloudkafka.com:9094',
                :"group.id"          => "drivers-producer",
                :"sasl.username"     => 'xz6befqu',
                :"sasl.password"     => 'ZnTqLiR0WxwLHX_jdiGChcbi4W-H9Mzd',
                :"security.protocol" => "SASL_SSL",
                :"sasl.mechanisms"   => "SCRAM-SHA-256"
      }

      topic = "xz6befqu-allocated-drivers"

      rdkafka = Rdkafka::Config.new(config)
      producer = rdkafka.producer

      driver = allocate_driver
      message = driver.to_json
      puts "Producing message #{message}"
      producer.produce(
          topic:   topic,
          payload: message,
          key:     "Allocation for order #{driver[:order_id]}"
      ).wait
  end
end