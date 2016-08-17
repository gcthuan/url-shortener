require "redis"
if ENV["REDIS_PRODUCTION_URL"]
	uri = URI.parse(ENV["REDIS_PRODUCTION_URL"])
	REDIS = Redis.new(host: uri.host, port: uri.port, timeout: 5)
else
	REDIS = Redis.new(url: "redis://localhost:6379/")
end

REDIS.setnx("counter", 2729)