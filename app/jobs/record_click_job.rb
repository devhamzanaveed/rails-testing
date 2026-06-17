class RecordClickJob < ApplicationJob
  queue_as :default

  def perform(link_id, ip_address:, user_agent:, referrer:)
    Click.create!(
      link_id: link_id,
      ip_address: ip_address,
      user_agent: user_agent,
      referrer: referrer
    )
  end
end
