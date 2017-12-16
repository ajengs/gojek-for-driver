module MessagingService
  def self.consume_and_alocate_order
    topic = "#{RdKafka::TOPIC_PREFIX}orders"
    consumer = RdKafka.consumer({ "group.id": "orders1" })
    
    puts 'consume'
    consumer.subscribe(topic)

    begin
      consumer.each do |message|
        puts "Message received: #{message}"
        order = JSON.parse(message.payload)

        self.produce_allocated(order)
      end
    rescue Rdkafka::RdkafkaError => e
      retry if e.is_partition_eof?
      raise
    end
  end


  def self.produce_allocated(order)
    topic = "#{RdKafka::TOPIC_PREFIX}allocated-drivers"
    producer = RdKafka.producer({ "group.id": "drivers-producer" })

    allocation = AllocationService.allocate_driver(order)

    unless allocation[:driver].nil?
      allocation.merge!({ status:'OK' })
    else
      allocation.merge!({ status:'NOT_FOUND' })
    end

    message = allocation.to_json

    puts "Producing message: #{message}"
    producer.produce(
        topic:   topic,
        payload: message,
        key:     "Allocation for order #{allocation[:order_id]}"
    ).wait
  end
end