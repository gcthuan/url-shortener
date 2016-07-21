class Shortener < ActiveRecord::Base

	def self.shorten(url)
		return "" if url.blank?
		url_hash = REDIS.incr("counter").to_s(16)
		REDIS.set("url:#{url_hash}:id", url)
		REDIS.lpush("global:urls", url)
		url_hash
	end

	def self.expand(url)
		url_hash = self.make_url_hash(url)
		if url_hash.empty?
			return ""
		else
			self.increase_click_count(url_hash)
			{REDIS.get("url:#{url_hash}:id") => self.get_click_count(url_hash)}
		end
	end

	def self.increase_click_count(url_hash)
		# url_hash = self.make_url_hash(url)
		REDIS.incr("click:#{url_hash}")
	end

	def self.get_click_count(url_hash)
		REDIS.get("click:#{url_hash}")
	end

	def self.make_url_hash(url)
		return "" if url.empty?
		url_hash = url.split(/.*\//)[1]
	end	

end
