class RedirectsController < ApplicationController
  def show
    link = Link.find_by!(short_code: params[:short_code])
    redirect_to link.original_url, allow_other_host: true
  end
end
