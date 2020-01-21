class Badge < ApplicationRecord
  has_and_belongs_to_many :users
  before_destroy { users.clear }
  has_and_belongs_to_many :test_passages
  before_destroy { test_passages.clear }
end
