class User < ApplicationRecord
  def tests_history(level)
    history = Test.where(level: level)
  end
end
