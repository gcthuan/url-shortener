class ShortenerController < ApplicationController
	protect_from_forgery with: :null_session

	# POST shorteners/shorten?url=
	def shorten
		@shortened_url, @click_count  = Shortener.shorten(params[:url]).first
	end

	# GET shorteners/expand?url=
	def visit
		@original_url = Shortener.expand(params[:url])
		redirect_to @original_url
	end

	# private

	# def shortener_params
	# 	params.fetch(:shortener, {}).permit(:url)
	# end
end
