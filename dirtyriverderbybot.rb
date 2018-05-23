#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'redis'
require 'twitter'

$redis = Redis.new(url: ENV["REDIS_URL"])

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

tweetIDList = []

drd = drd_replies.sample

#Get array of all IDs already replied to
#tweetIDList = $redis.keys('drd_tweet_ids')
if( $redis.exists('drd_tweet_ids') )
  tweetIDList = $redis.get('drd_tweet_ids')
  puts tweetIDList
else
  $redis.set('drd_tweet_ids', '[1]');
end

#Search/reply for River Cities Cup phrase
client.search("%22River+Cities+Cup%22", result_type: "recent").take(1).each do |tweet|
  #If tweet is in array, already responded so ignore, don't want to spam anyone
  puts tweet
  if( tweetIDList.include? tweet.id )
    #nothing, move on to next search or end function
  else
    #Store ID in array so we don't respond again later
    $redis.push('drd_tweet_ids',tweet.id)
    #Send actual tweet
    client.update("@#{tweet.user.screen_name} #{drd}", in_reply_to_status_id: tweet.id)
  end
end

#Search/reply for #RiverCitiesCup hashtag
#client.search("#RiverCitiesCup", result_type: "recent").take(1).each do |tweet|
  #Send actual tweet
#  client.update("@#{tweet.user.screen_name} #{drd}", in_reply_to_status_id: tweet.id)
#end