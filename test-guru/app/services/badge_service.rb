class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    deserve?
  end

  def deserve?
    return unless @test_passage.completed == true

    Badge.all.each do |badge|
      @test_passage.user.badges << badge if send "#{badge.kind}_award?"
      @test_passage.badges << badge if send "#{badge.kind}_award?"
    end
  end

  def completed
    TestPassage.where(user_id: @test_passage.user.id).where(completed: true).map(&:test_id)
  end

  def badge_by(category)
    tests_exist = Test.by_category(category).map(&:id)
    (completed & tests_exist).count == tests_exist.count
  end

  def badge_by_level(level)
    tests_exist = Test.by_level(level).map(&:id)
    (completed & tests_exist).count == tests_exist.count
  end

  def first_try_award?
    TestPassage.where(user_id: @test_passage.user.id).where(completed: true).where(test_id: @test_passage.test.id).count == 1
  end

  def full_category_award?
    (sorting_by_category[@test_passage.test.category.title] != "full_category") && badge_by(@test_passage.test.category.title)
  end

  def full_complexity_award?
    (sorting_by_level["full_complexity"] != @test_passage.test.level) && badge_by_level(@test_passage.test.level)
  end

  def sorting_by_category
    categories = TestPassage.where(user_id: @test_passage.user.id).joins(:badges).map(&:test).map(&:category).map(&:title).to_a
    badges = @test_passage.user.badges.map{|badges| badges.kind}.to_a
    categories.zip(badges).to_h
  end

  def sorting_by_level
    level = TestPassage.where(user_id: @test_passage.user.id).joins(:badges).map(&:test).map(&:level).to_a
    badges = @test_passage.user.badges.map{|badges| badges.kind}.to_a
    badges.zip(level).to_h
  end

end

