class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_token

private
  def generate_token
    begin
      self.token = SecureRandom.hex
    end while User.exists?(token: token)
  end
end
