class User < ApplicationRecord
  def tests_history(level)
    pp UserHistory.joins('INNER JOIN tests ON tests.id = tests_id').where('tests.level = :level', level: level).where(':short_name = user_histories.user', short_name: login)
  end
end
