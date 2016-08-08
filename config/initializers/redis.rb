require "redis"
url = ENV["REDIS_PRODUCTION_URL"] || "redis://localhost:6379/"
REDIS = Redis.new(url: url)
REDIS.setnx("counter", 2729)