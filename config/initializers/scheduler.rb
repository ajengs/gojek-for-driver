scheduler = Rufus::Scheduler::singleton

unless defined?(Rails::Console) || File.split($0).last == 'rake' || Rails.env.test?
  scheduler.every '5s' do
    ::MessagingService.consume_and_alocate_order
  end

  scheduler.every '10s' do
    ::MessagingService.consume_order_cancellation
  end
end
