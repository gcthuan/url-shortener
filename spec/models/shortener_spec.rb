require 'rails_helper'

RSpec.describe Shortener, type: :model do
  describe "shorten" do
  	it "returns empty result when empty input" do
  		@input = ""
  		@url = Shortener.shorten(@input)
  		expect(@url).to be_empty
  	end

    before(:each) do
      @input = "google.com"
      REDIS.set("counter", 2729)
    end
  	it "returns correct hex string when valid input" do
  		@url = Shortener.shorten(@input)
  		expect(@url).to eq("aaa")
  	end

  	it "increases the total url count by 1" do
  		@global_urls_count = REDIS.lrange("global:urls", 0, -1).length
  		@url = Shortener.shorten(@input)
  		expect(REDIS.lrange("global:urls", 0, -1).length).to eq(@global_urls_count+1)
  	end

  end

  describe "expand" do
    it "returns empty result when empty input" do
      @input = ""
      @url = Shortener.expand(@input)
      expect(@url).to be_empty
    end

    it "returns correct original url when valid input" do
      @original_url = "google.com"
      @shorten_url = "host_name/aaa"
      @result = Shortener.expand(@shorten_url)
      expect(@result).to eq(@original_url)
    end
  end
end
