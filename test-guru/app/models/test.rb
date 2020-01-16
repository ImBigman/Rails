class Test < ApplicationRecord
  def self.sorted_by_category(category)
    by_category(category).order(title: :desc).pluck(:title)
  end

  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :title, presence: true,
                    uniqueness: { scope: :level, message: "title and level pair should be unique!" }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(category) { joins(:category).where('categories.title = :category', category: category) }
  scope :by_level, ->(level) { where('level = :level', level: level) }
end
