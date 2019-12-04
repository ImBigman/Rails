class User < ApplicationRecord
  def tests_history(level)
    pp tests.where('level = :level', level: level)
  end

  has_many :user_histories
  has_many :tests, through: :user_histories
  has_many :author_tests, class_name: 'Test', foreign_key: :author_id

  validates :email, presence: true
end
