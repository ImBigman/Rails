class User < ApplicationRecord
  define_model_callbacks :deliver
  include MailForm::Delivery
  attributes :name, :email, :message, :created_at

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many :author_tests, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :badges, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :login, presence: true,
                    uniqueness: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  def tests_history(level)
    tests.where('level = :level', level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end
end
