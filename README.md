# DevisePasswordExpiratable

This is a simple, however wonderful devise extension to expire user password after a period.

## Installation

Add this line to your application's Gemfile:

    gem 'devise_password_expiratable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise_password_expiratable

## Usage

    u = User.create(:name => 'John Doe', :password => "john.doe")
    u.password_expired? # false
    u.password_still_valid? # true
    u.active_for_authentication? # true
    u.inactive_message # nil

    u.update(expiration_password_at: nil)
    u.password_expired? # true
    u.password_still_valid? # false
    u.active_for_authentication? # false
    u.inactive_message # :password_expired

    u.update(expiration_password_at: 1.second.ago)
    u.password_expired? # true
    u.password_still_valid? # false
    u.active_for_authentication? # false
    u.inactive_message # :password_expired

    u.update(expiration_password_at: 10.minutes.from_now)
    u.password_expired? # false
    u.password_still_valid? # true
    u.active_for_authentication? # true
    u.inactive_message # nil

#### Using with ActiveRecord
You need to create a migration, manually (there is no magic here):

    class DevisePasswordExpirableToUsers < ActiveRecord::Migration
      def up
        add_column :users, :expiration_password_at, :timestamp
        add_index :users, :expiration_password_at
      end

      def down
        remove_index :users, :expiration_password_at
        remove_column :users, :expiration_password_at
      end
    end

or

    class DevisePasswordExpirableToUsers < ActiveRecord::Migration
      def change
        change_table :users, bulk: true do |t|
          t.datetime :expiration_password_at
          t.index :expiration_password_at
        end
      end
    end


Include in your model:

    class User < ActiveRecord::Base
      devise :database_authentication, :password_expirable
    end

Adding two wonderful new public methods:

- password_still_valid? : checks whether password still valid
- password_expired? : checks whether password expired

And modifications to two other methods:

- active_for_authentication? : If password is expired returns false, else it preforms the super method
- inactive_message : If password is expired returns :password_expired, else it performs the super method

And add a before save callback and a auxiliar callback method:

- change_expiration_password_at : Changes expiration_password_at field ever that encrypted_password field is changed
- next_password_expiration_time : Returns a datetime with the moment that password will expires, based in password_expirate_in configuration of Devise

And add a devise configuration:

- password_expirate_in : The time you want to reach before any user's password expires. After this period, the user must change the password again. The default is 10 days.

## License

The devise_password_expirable is hosted on Github: https://github.com/jonathanccalixto/devise_password_expirable, where your contributions, forkings, comments and feedback are greatly welcomed.

Copyright (c) 2024 Yanotec, released under the MIT license.


## Contributing

1. Fork it ( http://github.com/jonathanccalixto/devise_password_expirable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request