require 'rails_helper'

RSpec.describe ShortenerController, type: :controller do
	render_views

	describe "POST #shorten" do
		before(:each) do
			post :shorten, url: "http://google.com", format: :json
		end

		it "returns 200 status code" do
			expect(response).to have_http_status(200)
		end

		it "returns a non empty result" do
			response_body = JSON.parse(response.body)
			expect(response.body["shortened_url"]).not_to be_empty
		end

		it "returns a string" do
			response_body = JSON.parse(response.body)
			expect(response.body["shortened_url"]).to be_a(String)
		end

		it "returns click count with the url" do
			puts response.body
			@click_count = JSON.parse(response.body)["click_count"]
			expect(@click_count).not_to be_blank
		end
	end

	describe "GET #visit" do
		before(:each) do
			get :visit, url: "localhost:3000/aaa", format: :json
		end

		it "returns 200 status code" do
			expect(response).to have_http_status(200)
		end

		it "returns a non empty result" do
			response_body = JSON.parse(response.body)
			expect(response.body["original_url"]).not_to be_empty
		end
 
		it "returns the original url" do
			@original_url = JSON.parse(response.body)["original_url"]
			expect(@original_url).to be_a(String)
		end

	end
end
