class ShortenerController < ApplicationController

	# GET shorteners/shorten?url=
	def shorten
		@shortened_url = @host_name + "/" + Shortener.shorten(params[:url])
	end

	# GET shorteners/expand?url=
	def expand
		@original_url = Shortener.expand(params[:url])
	end

	# private

	# def shortener_params
	# 	params.fetch(:shortener, {}).permit(:url)
	# end
end
