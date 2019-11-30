class User < ApplicationRecord
  def tests_history(level)
    pp UserHistory.joins('INNER JOIN tests ON tests.id = tests_id').where('tests.level = :level', level: level).where(':id = user_histories.users_id', id: id)
  end
end
