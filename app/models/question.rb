class Question < ActiveRecord::Base
  has_many :responses,
            foreign_key: :question_id,
            inverse_of: :question

  has_many :users,
            through: :responses,
            inverse_of: :question
end
