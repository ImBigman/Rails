class TestsController < ApplicationController
  def index
    render inline: '<p> Существуют тесты категорий: <%= Category.all.pluck(:title).join(", ") %> </p> <p> На следующие темы: <%= Test.all.pluck(:title).join(", ") %> </p>'
  end

  def show
    @test = Test.find(params[:id])
    render inline: '<p> Название теста: <%= @test.title %>, уровень сложности: <%= @test.level %>, тест из категории: <%= @test.category.title %>. </p>'
  end
end
