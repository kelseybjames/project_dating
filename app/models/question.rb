class Question < ActiveRecord::Base
  has_many :responses,
            foreign_key: :question_id,
            dependent: :destroy,
            inverse_of: :question

  has_many :users,
            through: :responses,
            inverse_of: :questions
end
