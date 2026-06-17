class RedirectsController < ApplicationController
  def show
    data = cached_link(params[:short_code])
    return head :not_found unless data

    RecordClickJob.perform_later(
      data[:id],
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer:   request.referer
    )

    redirect_to data[:original_url], allow_other_host: true
  end

  private

  def cached_link(code)
    Rails.cache.fetch("link:#{code}", expires_in: 1.hour, skip_nil: true) do
      link = Link.find_by(short_code: code)
      link && { id: link.id, original_url: link.original_url }
    end
  end
end
