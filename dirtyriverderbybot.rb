#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'redis'
require 'twitter'

$redis = Redis.new(url: ENV["REDIS_URL"])

client = Twitter::REST::Client.new do |config|
	config.consumer_key			= ENV["TWITTER_CONS_KEY"]
	config.consumer_secret		= ENV["TWITTER_CONS_SECRET"]
	config.access_token			= ENV["TWITTER_TOKEN"]
	config.access_token_secret	= ENV["TWITTER_TOKEN_SECRET"]
end

drd_replies = [
  "Did you mean 'Dirty River Derby'? #dirtyriverderby",
  "I think you meant #DirtyRiverDerby",
  "Now and forever, #DirtyRiverDerby",
  "The #DirtyRiverDerby will never die"
]

tweetIDList = []

drd = drd_replies.sample

#Get array of all IDs already replied to
if( $redis.exists('drd_tweet_ids') )
  tweetIDList = $redis.get('drd_tweet_ids').split(",").map { |s| s.to_i }
  puts tweetIDList
else
  $redis.set('drd_tweet_ids', '1');
end

#Search/reply for River Cities Cup + related phrases/hastags
client.search('"River Cities Rivalry" OR "River Cities Cup" OR %23RiverCitiesRivalry%2C OR %23RiverCitiesCup', result_type: "recent").take(5).each do |tweet|
  #If tweet is in array, already responded so ignore, don't want to spam anyone
  puts tweet
  puts tweet.inspect

  if( tweetIDList.include? tweet.id )
    #nothing, move on to next search or end function
    puts 'Nothing to see here, already responded'
  else
    puts 'Responding, saving ID'
    #Store ID in array so we don't respond again later
    #$redis.push('drd_tweet_ids',tweet.id)
    tweetIDList.push(tweet.id)
    $redis.set('drd_tweet_ids',tweetIDList)
    #Send actual tweet
    client.update("@#{tweet.user.screen_name} #{drd}", in_reply_to_status_id: tweet.id)
  end
end