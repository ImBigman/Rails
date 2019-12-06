class Answer < ApplicationRecord
  belongs_to :question
  scope :right_answer, -> { where(correct: true) }
  validates :body, presence: true
  validate :validate_answers_quantity, on: :create

  private

  def validate_answers_quantity
    if question.answers.count > 4
      errors.add(:answer, message: "wrong quantity of answers!" )
    end
  end
end
