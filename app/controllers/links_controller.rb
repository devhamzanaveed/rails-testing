class LinksController < ApplicationController
  def index
    @link = Link.new
    @links = Link.order(created_at: :desc)
  end

  def create
    result = ShortenUrl.call(original_url: link_params[:original_url])

    if result.success?
      redirect_to root_path, notice: "Short link created."
    else
      @link  = result.link || Link.new(link_params)
      @links = Link.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end


  private

  def link_params
    params.require(:link).permit(:original_url)
  end
end
