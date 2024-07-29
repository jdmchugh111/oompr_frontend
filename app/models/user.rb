class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.name = response[:info][:name]
      u.email = response[:info][:email]
    end
  end
end
