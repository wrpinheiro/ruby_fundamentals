class Tweet
  attr_accessor :user, :status

  def initialize(user, status)
    @user, @status = user, status
  end

  def to_s
    "#{user}: #{status}"
  end
end

tweet = Tweet.new('Joseph', 'compiling!')
puts tweet.to_s

# Struct can do exactly the same as above

# we call remove_const to 'unload' previously defined Tweet class
Object.send(:remove_const, :Tweet)

Tweet = Struct.new(:user, :status) do
  def to_s
    "#{user}: #{status}"
  end
end
tweet = Tweet.new('Joseph', 'compiling!')
puts tweet.to_s

class Timeline
  def initialize(tweets = [])
    @tweets = tweets
  end

  attr_reader :tweets
  alias_method :contents, :tweets

  def print
    puts tweets.join("\n")
  end
end

timeline = Timeline.new(['One', 'Two', 'Three'])
timeline.print

class Timeline
  alias_method :old_print, :print

  def print
    authenticate!
    old_print
  end

  def authenticate!
    puts 'Authenticating...'
  end
end

timeline = Timeline.new(['One', 'Two', 'Three'])
timeline.print

# The class tweet below has 3 methods very similar.
# We can reduce this duplication using define_method
#
# class Tweet
#   def draft
#     @status = :draft
#   end

#   def posted
#     @status = :posted
#   end

#   def deleted
#     @status = :deleted
#   end
# end

class Tweet
  states = [:draft, :posted, :deleted]
  states.each do |state|
    define_method state do
      @status = state
    end
  end
end

Object.send(:remove_const, :Timeline)

class Timeline
  def initialize(tweets)
    @tweets = tweets
  end

  def contents
    @tweets
  end

  private

  def direct_messages
  end
end

tweets = ['Compiling!', 'Bundling...']
timeline = Timeline.new(tweets)

timeline.contents

timeline.send(:contents)
timeline.send('contents')
#send can also call protected or private methods
timeline.send(:direct_messages)

timeline.public_send(:contents)
# public_send can call only public methods
# timeline.public_send(:direct_messages)



























