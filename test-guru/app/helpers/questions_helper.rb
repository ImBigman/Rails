module QuestionsHelper
  def question_header(question)
    if question.persisted?
      render inline: '<h2>Edit <%= @question.test.title %> question</h2><br>'
    else
      render inline: '<h2>Create New <%= @test.title %> question</h2><br>'
    end
  end
end
