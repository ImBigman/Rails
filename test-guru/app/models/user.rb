class User < ApplicationRecord
  def tests_history(level)
    pp UserHistory.joins('INNER JOIN tests ON tests.id = tests_id').where('tests.level = :level', level: level).where(':id = user_histories.users_id', id: id)
  end
  has_many :user_histories
  has_many :tests, through: :user_histories
  has_and_belongs_to_many :tests
end
