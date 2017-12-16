class RdKafka
  CONFIG = {
    :"bootstrap.servers" => 'velomobile-01.srvs.cloudkafka.com:9094,velomobile-02.srvs.cloudkafka.com:9094,velomobile-03.srvs.cloudkafka.com:9094',
    :"sasl.username"     => 'xz6befqu',
    :"sasl.password"     => 'ZnTqLiR0WxwLHX_jdiGChcbi4W-H9Mzd',
    :"security.protocol" => "SASL_SSL",
    :"sasl.mechanisms"   => "SCRAM-SHA-256"
  }

  TOPIC_PREFIX = "xz6befqu-"

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