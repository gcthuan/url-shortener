class ShortenerController < ApplicationController

	# GET shorteners/shorten
	def shorten
		@shortened_url = @host_name + "/" + Shortener.shorten(params[:url])
	end

	private

	def shortener_params
		params.fetch(:shortener, {}).permit(:url)
	end
end
