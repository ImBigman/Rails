class GistQuestionService

  def initialize(question, client: Octokit::Client.new(:access_token => ENV['TOKEN']))
    @question = question
    @test = @question.test
    @client = client || GitHubClient.new
  end

  def call
    @client.create_gist(gist_params)
  end

  private

  def gist_params
    {
      description: I18n.t('gist description', test: @test.title),
      files: {
        "test_guru_#{I18n.t('gist filename', test: @test.title, question: @question.id)}.txt": {
              content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end