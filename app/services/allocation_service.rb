module AllocationService
  RADIUS = 1

  def self.allocate_driver(params)
    order = initialize_order(params)

    boundary_box = boundary(order.origin_coordinates.split(" "))

    users = User.find_by_location(boundary_box, order.type_id)
    driver = nil
    
    unless users.nil?
      driver = users.min_by { |u| u.orders.count }
    end

    unless driver.nil?
      order.user = driver
      order.save
      if order.payment_type == 'Go-Pay'
        puts "'allocate_driver ' #{order.price}"
        response = ::GopayService.topup(driver, order.price)
      end
    end

    {
      order_id: order.external_id,
      driver: driver
    }

    #TODO push notification
  end

  def self.boundary(center)
    Geocoder::Calculations.bounding_box(center, RADIUS)
  end

  def self.distance(origin, destination)
    Geocoder::Calculations.distance_between(origin, destination)
  end

  def self.create_order(order_id, driver)
    driver.orders.create()
  end

  #TODO it will be used if using push notification
  def self.choose_driver(drivers)
    users.each do |user|
      drivers << {
        user: user,
        distance: distance(origin_point, [user.latitude, user.longitude])
      }
    end
    drivers = drivers.min_by { |a| a[:distance] }
  end

  def self.initialize_order(params)
    puts "initialize_order #{params['est_price']}"
    Order.new(
      external_id: params["id"],
      origin: params["origin"],
      destination: params["destination"],
      origin_coordinates: "#{params["origin_latitude"]} #{params["origin_longitude"]}",
      destination_coordinates: "#{params["destination_latitude"]} #{params["destination_longitude"]}",
      type_id: params["type_id"],
      status: "Initialized",
      payment_type: params["payment_type"],
      price: params["est_price"]
    )
  end

  def self.cancel_if_exists(params)
    order = initialize_order(params)
    begin
      allocated_order = Order.find_by(external_id: order.external_id)
      unless allocated_order.nil?
        allocated_order.update(status: "Cancelled by System")
        if order.payment_type == 'Go-Pay'
          response = ::GopayService.use(order.user, order.price)
        end
      end
    ensure
      ActiveRecord::Base.connection_pool.release_connection
    end
  end
end