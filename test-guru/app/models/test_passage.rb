class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_update :next_question
  before_validation :before_validation_set_first_question, on: :create

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    self.current_question = next_question
    save!
  end

  def completed?
    current_question.nil?
  end

  def percentage_result
    a = test.questions.count
    b = correct_questions
    (Float(b * 100) / a).ceil
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.right_answer
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question).first
  end
end
