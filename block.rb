# simple iterations
number_array = [1, 2, 3, 4, 5, 6]

number_array.each do |number|
  puts number
end

number_array.each { |number| puts number }

# yield
def print_block
  puts yield
end

print_block { "block" }

def block_param_evaluation
  value = yield 'any string'
  puts value
end

block_param_evaluation { |param| param.reverse }

# Refactor with yield
class Tweet
  attr_accessor :tweet

  def initialize(tweet)
    @tweet = tweet
  end

  def cache
  end
end

class User
  attr_accessor :tweets
  attr_accessor :name
  attr_accessor :friends

  def initialize(name, tweets)
    @user = user
    @tweets = tweets
    @friends = []
  end

  def add_friend(friend)
    @friends << friend
  end
end

class Timeline
  def initialize(user)
    @user = user
  end

  def list_tweets
    @user.friends.each do |friend|
      friend.tweets.each { |tweet| puts tweet }
    end
  end

  def store_tweets
    @user.friends.each do |frient|
      friend.tweets.each { |tweet| tweet.cache }
    end
  end
end

john = User.new(name: "John", tweets: [Tweet.new("first tweet!")])
carl = User.new(name: "Carl", tweets: [Tweet.new("hey buddy!!!")])
carl.add_friend(john)

timeline = Timeline(carl)
timeline.list_tweets
timeline.store_tweets
