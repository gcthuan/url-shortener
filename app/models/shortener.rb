class Shortener < ActiveRecord::Base

	# shorten the url and return the shortened string with title and click count
	# Example: "https://google.com" -> [aaa, title, 1]
	def self.shorten(url)
		return "" if url.blank?
		url_hash = REDIS.get("url:#{url}")
		if url_hash.nil?
			url_hash = REDIS.incr("counter").to_s(16)
			REDIS.set("url_hash:#{url_hash}", url)
			REDIS.set("url:#{url}", url_hash)
			REDIS.set("click:#{url_hash}", 0)
		end
		[url_hash, self.get_title(url), self.get_click_count(url_hash)]
	end

	# expand the shortened url and return the original url
	# Example: "domain-name.com/aaa" -> "https://google.com"
	def self.expand(url)
		return "" if url.blank?
		url_hash = self.make_url_hash(url)
		original_url = REDIS.get("url_hash:#{url_hash}")
		if original_url.nil?
			return ""
		else
			self.increase_click_count(url_hash)
			original_url
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
		url_array = url.split(/.*\//)
		url_array[1].blank? ? url_array[0] : url_array[1]
	end

	def self.get_title(url)
		body = self.get_url_body(url)
		self.parse_html(body).at_css('title').text.force_encoding("UTF-8")
	end

	def self.parse_html(document)
		Oga.parse_html(document)
	end

	def self.get_url_body(url)
		HTTParty.get(url).body
	end

end
