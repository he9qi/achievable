# Achievable

This is a simple achievement builder for rails


## Installation

To install Achievable, simply install the gem:

    gem install achievable
    
Run generator to generate config information in `application.rb`, migration file `achievable_migration`, and model files `achievement.rb` and `achieving.rb`

    rails g achievable MODEL
    
MODEL here is the achiever - model that receives achievement, for example: user
    
## Configuration for Resque
[resque](https://github.com/defunkt/resque)

Achievable also provides resque functionality. Enable or disable resque in `config/application.rb`:

    config.achievable.resque_enable = false

## Usage

### Specify which model is used for the achiever, take user for example:

    class User < ActiveRecord::Base
      include Achievable::Achiever
      has_many :posts
    end

### Specify which column to check for achievement of in a model, the name of the achievement, receiver of achievement and condition in which achiever has to meet. If receiver is not set, then the model itself is the receiver.

    class User < ActiveRecord::Base
      ...
      achievable :image_url,  "first_time_edit_avatar"
      ...
    end
    
    class Post < ActiveRecord::Base
      ...
      achievable :description,  "first_time_edit_description", :receiver => :user
      ...
    end
    
    class User < ActiveRecord::Base
      ... 
      achievable :tags_count, "tags_500_times" :condition => lambda { |u| u.tags_count = 500 }
      ...
    end

### Note that achievement items have to be created FIRST!

## TODO

    