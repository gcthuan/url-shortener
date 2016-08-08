class ShortenerController < ApplicationController
	protect_from_forgery with: :null_session

	# POST shorteners/shorten?url=
	def shorten
		@shortened_url, @title, @click_count  = Shortener.shorten(params[:url])
	end

	# GET shorteners/expand?url=
	def visit
		@original_url = Shortener.expand(params[:url])
		respond_to do |format|
			format.html { redirect_to @original_url }
			format.json
		end
	end

	# private

	# def shortener_params
	# 	params.fetch(:shortener, {}).permit(:url)
	# end
end
