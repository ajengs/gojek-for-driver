# class ScheController < ApplicationController

#   # GET /sche/
#   #
#   def index

#     job_id =
#       Rufus::Scheduler.singleton.in '5s' do
#         puts "time flies, it's now #{Time.now}"
#       end

#     render :text => "scheduled job #{job_id}"
#   end
# end

scheduler = Rufus::Scheduler::singleton


scheduler.every '5s' do

  config = {
            :"bootstrap.servers" => 'velomobile-01.srvs.cloudkafka.com:9094,velomobile-02.srvs.cloudkafka.com:9094,velomobile-03.srvs.cloudkafka.com:9094',
            :"group.id"          => "orders1",
            :"sasl.username"     => 'xz6befqu',
            :"sasl.password"     => 'ZnTqLiR0WxwLHX_jdiGChcbi4W-H9Mzd',
            :"security.protocol" => "SASL_SSL",
            :"sasl.mechanisms"   => "SCRAM-SHA-256"
  }

  topic = "xz6befqu-orders"

  rdkafka = Rdkafka::Config.new(config)
  consumer = rdkafka.consumer
  
  puts 'consume'
  consumer.subscribe(topic)
  begin
    consumer.each do |message|
      puts "Message received: #{message}"
      order = JSON.parse(message.payload)
      # drivers = User.find_by('latitude BETWEEN :origin AND :destination', origin: order["origin_latitude"], destination: order["destination_latitude"])
      # puts drivers
      allocation = Allocation.new(order)
      puts "Producing message: #{allocation.allocate_driver}"
      allocation.produce_allocated
    end
  rescue Rdkafka::RdkafkaError => e
    retry if e.is_partition_eof?
    raise
  end

end

# puts message
