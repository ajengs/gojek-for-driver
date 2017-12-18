require 'allocation_service'
module MessagingService
  def self.consume_and_alocate_order
    topic = "#{RdKafka::TOPIC_PREFIX}orders"
    consumer = RdKafka.consumer({ "group.id": "orders1" })
    puts 'consume orders'
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

  def self.consume_order_cancellation
    topic = "#{RdKafka::TOPIC_PREFIX}order-cancellation"
    consumer = RdKafka.consumer({ "group.id": "cancellation-consumer1" })
    puts 'consume cancellation'
    consumer.subscribe(topic)

    begin
      consumer.each do |message|
        puts "Message received: #{message}"
        order = JSON.parse(message.payload)

        AllocationService.cancel_if_exists(order)
      end
    rescue Rdkafka::RdkafkaError => e
      retry if e.is_partition_eof?
      raise
    end
  end
end