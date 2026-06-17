class RedirectsController < ApplicationController
  def show
    link = Link.find_by!(short_code: params[:short_code])

    RecordClickJob.perform_later(
      link.id,
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer:   request.referer
    )

    redirect_to link.original_url, allow_other_host: true
  end
end
