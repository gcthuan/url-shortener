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

    it "does not create new shortened url for an existed shortened url" do
      @url = Shortener.shorten(@input)
      expect(@url).to eq("aaa")
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
      @shortened_url = "host_name/aaa"
      @url, @click_count = Shortener.expand(@shortened_url).first
      expect(@url).to eq(@original_url)
    end
  end

  describe "increase click count" do
    it "increases visit count by 1 per visit" do
      REDIS.set("click:aaa", 1)
      Shortener.increase_click_count("aaa")
      expect(REDIS.get("click:aaa")).to eq("2")
    end
  end

  describe "get_click_count" do
    it "return the correct click count of a url" do
      REDIS.set("click:aaa", 10)
      expect(Shortener.get_click_count("aaa")).to eq("10")
    end
  end

  describe "make_url_hash" do
    it "returns empty string when empty input" do
      @url = ""
      expect(Shortener.make_url_hash(@url)).to be_empty
    end

    it "gets the correct hex string of an url" do
      @url = "www/sho.rt/abc"
      expect(Shortener.make_url_hash(@url)).to eq("abc")
    end
  end
end
