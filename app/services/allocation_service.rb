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
      order.type = driver.type
      order.save
      driver.set_location(order.destination)
    end

    allocation = {order_id: order.external_id, driver: driver}
    send_allocation(allocation)

    #TODO push notification
  end

  def self.send_allocation(allocation)
    unless allocation[:driver].nil?
      allocation.merge!({ status:'OK' })
    else
      allocation.merge!({ status:'NOT_FOUND' })
    end
    ::MessagingService.produce_allocated(allocation)
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
      external_id: params[:id],
      origin: params[:origin],
      destination: params[:destination],
      origin_coordinates: params[:origin_coordinates],
      destination_coordinates: params[:destination_coordinates],
      status: "Initialized",
      payment_type: params[:payment_type],
      price: params[:est_price]
    )
  end

  def self.cancel_if_exists(params)
    begin
      allocated_order = Order.find_by(external_id: params[:id])
      unless allocated_order.nil?
        allocated_order.update(status: "Cancelled by System")
        allocated_order.user.set_location(order.origin)
      end
    ensure
      ActiveRecord::Base.connection_pool.release_connection
    end
  end

  BASE_URI = 'http://localhost:3000/api/v1/'

  def self.send_allocation_request(allocation)
    unless allocation[:driver].nil?
      allocation.merge!({ status:'OK' })
    else
      allocation.merge!({ status:'NOT_FOUND' })
    end
    opts = {
      body: {
        params: allocation
      }
    }
    response = HTTParty.post("#{BASE_URI}allocate", opts)
    RequestResponse.json_to_hash(response.body)
  end
end