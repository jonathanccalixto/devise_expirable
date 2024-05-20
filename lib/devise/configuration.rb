module Devise
  # Time interval to password expires
  mattr_accessor :password_expirate_in
  @@password_expirate_in = 10.days
end
