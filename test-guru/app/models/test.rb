class Test < ApplicationRecord
  def self.sorted_by_category(category)
    Test.joins('INNER JOIN categories ON tests.category_id = categories.id').where('categories.title = :category', category: category).order(title: :desc).pluck(:title)
  end
end
