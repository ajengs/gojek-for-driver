class RdKafka
  CONFIG = {
    :"bootstrap.servers" => ENV['KAFKA_BOOTSTRAP_SERVERS'],
    :"sasl.username"     => ENV['KAFKA_SASL_USERNAME'],
    :"sasl.password"     => ENV['KAFKA_SASL_PASSWORD'],
    :"security.protocol" => "SASL_SSL",
    :"sasl.mechanisms"   => "SCRAM-SHA-256"
  }

  TOPIC_PREFIX = ENV['KAFKA_TOPIC_PREFIX']

  def self.consumer(params)
    config = CONFIG.merge(params)
    rdkafka = Rdkafka::Config.new(config)
    rdkafka.consumer
  end

  def self.producer(params)
    config = CONFIG.merge(params)
    rdkafka = Rdkafka::Config.new(config)
    rdkafka.producer
  end
end