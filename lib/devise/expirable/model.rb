require 'devise/strategies/database_authenticatable'

module Devise
  module Models
    module Expirable
      extend ActiveSupport::Concern

      included do
        before_save :change_expiration_password_at
      end

      def password_expirate_in
        self.class.password_expirate_in
      end

      def active_for_authentication?
        password_still_valid? && super
      end

      def password_still_valid?
        return false unless expiration_password_at

        expiration_password_at >= Time.current
      end

      def password_expired?
        !password_still_valid?
      end

      def inactive_message
        password_expired? ? :password_expired : super
      end

      protected

      def next_password_expiration_time
        password_expirate_in.from_now
      end

      private

      def change_expiration_password_at
        return unless encrypted_password_changed?

        self.expiration_password_at = next_password_expiration_time
      end

      module ClassMethods
        Devise::Models.config(self, :password_expirate_in)
      end
    end
  end
end
