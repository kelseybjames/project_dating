class User < ActiveRecord::Base
  has_many :responses,
            foreign_key: :user_id,
            dependent: :destroy,
            inverse_of: :user

  has_many :questions, 
            through: :responses,
            inverse_of: :users

  accepts_nested_attributes_for :responses,
                  reject_if: :all_blank,
                  allow_destroy: true


  def full_name
    "#{first_name} #{last_name}"
  end

end