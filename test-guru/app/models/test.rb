class Test < ApplicationRecord
  def self.sorted_by_category(category)
    by_category(category).order(title: :desc).pluck(:title)
  end

  belongs_to :category
  has_many :questions
  has_many :user_histories
  has_many :users, through: :user_histories
  belongs_to :author, class_name: 'User'

  validates :title, presence: true,
                    uniqueness: { scope: :level, message: "title and level pair should be unique!" }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(category) { joins(:category).where('categories.title = :category', category: category) }
end
