class Test < ApplicationRecord
  def self.sorted_by_category(category)
    Test.joins('INNER JOIN categories ON tests.category_id = categories.id').where('categories.title = :category', category: category).order(title: :desc).pluck(:title)
  end
  belongs_to :category
  has_many :questions
  has_many :user_histories
  has_many :users, through: :user_histories
  has_and_belongs_to_many :users
end
