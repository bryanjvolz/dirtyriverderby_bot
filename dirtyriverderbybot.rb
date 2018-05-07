#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'twitter'

client = Twitter::REST::Client.new do |config|
	config.consumer_key			= 'tVhCE4dDregfjBZO53qzZYNKs'
	config.consumer_secret		= 'caPS1gbLN9ZRPPmsap1vedJi6nLuoiOjkXYjjjnxnaqrKxujYJ'
	config.access_token			= '983719735442509824-kmskSi9RK8RP7feMz4p56oHYBDt0Hf4'
	config.access_token_secret	= 'XXoIO0mbtZh7hQvvXpb4hV8a4pabRzqLKndGc4j41858R'
end

drd_replies = [
  "Did you mean 'Dirty River Derby'? #dirtyriverderby",
  "I think you meant #DirtyRiverDerby",
]

drd = drd_replies.sample

client.search("%22River+Cities+Cup%22", result_type: "recent").take(1).each do |tweet|

  client.update("@#{tweet.user.screen_name} #{drd}", in_reply_to_status_id: tweet.id)

end