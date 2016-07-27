class Shortener < ActiveRecord::Base

	# shorten the url and return the shortened string
	# Example: www.google.com -> aaa
	def self.shorten(url)
		return "" if url.blank?
		existing_shortened_url = REDIS.get("url:#{url}")
		if existing_shortened_url.nil?
			url_hash = REDIS.incr("counter").to_s(16)
			REDIS.set("url_hash:#{url_hash}", url)
			REDIS.set("url:#{url}", url_hash)
			url_hash
		else
			existing_shortened_url
		end
	end

	# expand the shortened url and return the original url + clicks count
	# Example: www.domain-name.com/aaa -> {"www.google.com" => 3}
	def self.expand(url)
		return "" if url.blank?
		url_hash = self.make_url_hash(url)
		original_url = REDIS.get("url_hash:#{url_hash}")
		if original_url.nil?
			return ""
		else
			{original_url => self.increase_click_count(url_hash) }
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
