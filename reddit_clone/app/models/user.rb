# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    #validations
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    before_validation :ensure_session_token
    attr_reader :password

    #associations

    #SPIRE
    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            return @user
        else
            return nil
        end
    end

    #checks the @password validations, and it sets the password_digest
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    #create a BCrypt object, use #new to retrieve the BCrpyt object with the password
    #use the BCrypt method to check
    def is_password?(password)
        bcrypt_object = BCrypt::Password.new(self.password_digest)
        bcrypt_object.is_password?(password)
    end

    #reset the user's session token
    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save! #important
        self.session_token
    end

    def generate_unique_session_token
        token = SecureRandom::urlsafe_base64
        while User.exists?(session_token: token)
            token = SecureRandom::urlsafe_base64
        end
        token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    #migrations --> models --> routes --> controllers --> views
end
