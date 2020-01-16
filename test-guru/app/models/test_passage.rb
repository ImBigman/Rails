class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true
  has_many :badges, dependent: :destroy

  before_validation :before_validation_set_first_question, on: :create

  BOUNDARY_OF_SUCCESS = 85

  before_update do
    self.current_question = next_question
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def success?
    percentage_result < BOUNDARY_OF_SUCCESS
  end

  def percentage_result
    a = test.questions.count
    b = correct_questions
    (Float(b * 100) / a).ceil
  end

  def current_question_number
    test.questions.to_a.index(current_question) + 1
  end

  def all_questions
    test.questions.count
  end

  def progress
    Float(((current_question_number - 1) * 100) / all_questions).ceil
  end

  def first_time
    TestPassage.where(user_id: user.id).where(completed: true).where(test_id: test.id).count == 1
  end

  def badge_by(category)
    completed = TestPassage.where(user_id: user.id).where(completed: true).map(&:test_id)
    tests_exist = Test.by_category(category).map(&:id)
    (completed & tests_exist).count == tests_exist.count
  end

  def badge_by_level(level)
    completed = TestPassage.where(user_id: user.id).where(completed: true).map(&:test_id)
    tests_exist = Test.by_level(level).map(&:id)
    (completed & tests_exist).count == tests_exist.count
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    return if answer_ids.nil?

    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.right_answer
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question).first
  end
end
