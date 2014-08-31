my_proc = Proc.new { puts 'tweet' }
my_proc.call

my_proc = lambda { puts 'almost the same as above' }
my_proc.call

stabby_lambda = -> { puts 'syntax "->" is known as stabby lambda!' }
stabby_lambda.call

class Tweet
  def initialize(user, password)
    @user = user
    @password = password
  end

  def authenticate?(user, password)
    true
  end

  def post(msg,success,error)
    if authenticate?(@user, @password)
      success.call
    else
      error.call
    end
  end  
end

tweet = Tweet.new('a user', 'a pass')
success = -> { puts 'Sent' }
error = -> { raise 'Auth error' } 
tweet.post('A message', success, error)

# Using proc/lambda as a block
tweets = ['First', 'Second', 'Third']
printer = lambda { |tweet| puts tweet }
# tweets.each(printer) # won't work because each expects a block not a proc/lambda. Must use &
tweets.each(&printer) # the & turns proc into a block

class Timeline
  attr_accessor :tweets

  def initialize(tweets)
    @tweets = tweets
  end

  def each(&block)      # turns a block into a proc
    tweets.each(&block) # turns the proc back into a block
  end
end

timeline = Timeline.new(tweets)
puts '=> Showing tweets'
timeline.each do |tweet|
  puts tweet
end

#both are equivalent
tweets.map { |tweet| tweet.user }
tweets.map(&:user)

# this is not allowed
# tweets.maps(&:user.name)

# block_given?
timeline = Timeline.new
timeline.tweets = ['One', 'Two']

timeline.print

timeline.print { |tweet|
  "tweet: #{tweet}"
}

class Timeline
  ...
  def print
    if block_given?
      tweets.each { |tweets| puts yield tweet }
    else
      puts tweets.join(', ')
    end
  end
end

# Closure
# the current state of a local variable is preserved when a lambda is created
def tweet_at(user)
  lambda { |tweet| puts "#{user}: #{tweet}"
end

a_tweet = tweets_as('joseph')
a_tweet.call('Hi there!!!') # joseph: Hi there!!!

