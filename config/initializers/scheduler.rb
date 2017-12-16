scheduler = Rufus::Scheduler::singleton

scheduler.every '5s' do
  MessagingService.consume_and_alocate_order
end
