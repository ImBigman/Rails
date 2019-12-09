module QuestionsHelper
  def question_header(question)
    if question.persisted?
      render inline: '<h3>Edit <%= @question.test.title %> question</h3>'
    else
      render inline: '<h3>Create New <%= @test.title %> question</h3>'
    end
  end
end
