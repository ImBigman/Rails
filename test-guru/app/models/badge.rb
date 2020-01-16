class Badge < ApplicationRecord
  belongs_to :user
  belongs_to :test_passage
end
