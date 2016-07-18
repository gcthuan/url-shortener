require 'rails_helper'

RSpec.describe ShortenerController, type: :controller do
	render_views

	describe "GET #shorten" do
		before(:each) do
			get :shorten, url: "www.google.com", format: :json
		end

		it "returns 200 status code" do
			expect(response).to have_http_status(200)
		end

		it "returns a non empty result" do
			response_body = JSON.parse(response.body)
			expect(response.body["shortened_url"]).not_to be_empty
		end

		it "returns a shortened url" do
			response_body = JSON.parse(response.body)
			expect(response.body["shortened_url"]).to be_a(String)
		end
	end
end
