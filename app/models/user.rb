class User < ActiveRecord::Base
  has_many :responses,
            foreign_key: :user_id,
            inverse_of: :user

  has_many :questions, 
            through: :responses,
            inverse_of: :user

  def full_name
    "#{first_name} #{last_name}"
  end

end