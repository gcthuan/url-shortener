class ShortenerController < ApplicationController

	# GET shorteners/shorten?url=
	def shorten
		@shortened_url = @host_name + "/" + Shortener.shorten(params[:url])
	end

	# GET shorteners/expand?url=
	def visit
		@original_url, @click_count = Shortener.expand(params[:url]).first
	end

	# private

	# def shortener_params
	# 	params.fetch(:shortener, {}).permit(:url)
	# end
end
