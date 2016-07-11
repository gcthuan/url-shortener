class Shortener < ActiveRecord::Base

	def self.shorten(url)
		return "" if url.empty?
		url_hash = REDIS.incr("counter").to_s(16)
		REDIS.set("url:#{url_hash}:id", url)
		REDIS.lpush("global:urls", url_hash)
		url_hash
	end

	def self.expand(url)
		return "" if url.empty?
		url_hash = url.split(/.*\//)[1]
		REDIS.get("url:#{url_hash}:id")
	end

end
