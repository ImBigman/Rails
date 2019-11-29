# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
                         { first_name: 'Donatello', second_name: 'Splinters', login: 'Donny', email: 'ninja_turtles_1@gmail.com' },
                         { first_name: 'Raphael', second_name: 'Splinters', login: 'Raf', email: 'ninja_turtles_2@gmail.com' },
                         { first_name: 'Michelangelo', second_name: 'Splinters', login: 'Mike', email: 'ninja_turtles_3@gmail.com' },
                         { first_name: 'Leonardo', second_name: 'Splinters', login: 'Leo', email: 'ninja_turtles_4@gmail.com' }
                    ])
categories = Category.create([
                                  { title: 'Backend' },
                                  { title: 'Frontend' },
                                  { title: 'Full stack' }
                             ])
tests = Test.create([
                         { title: 'CSS', level: 1, category_id: categories[1].id },
                         { title: 'HTML', level: 0, category_id: categories[1].id },
                         { title: 'Basics of JS', level: 1, category_id: categories[1].id },
                         { title: 'Ruby on Rails', level: 3, category_id: categories[0].id },
                         { title: 'Package managers', level: 2, category_id: categories[2].id }
                    ])
questions = Question.create([
                                { body: 'Basic SEO', test_id: tests[1].id },
                                { body: 'Box model', test_id: tests[0].id },
                                { body: 'DOM manipulation', test_id: tests[2].id },
                                { body: 'MVC on Rails', test_id: tests[3].id },
                                { body: 'npm', test_id: tests[4].id }
                            ])
answers = Answer.create([
                            { body: 'Meta description tag', correct: true, question_id: questions[0].id },
                            { body: 'Properties controlling the flow of content in a box', correct: true, question_id: questions[1].id },
                            { body: 'querySelector(), addEventListener()', correct: true, question_id: questions[2].id },
                            { body: 'Each component of the model-view-controller architecture has its place within the app subdirectory', correct: true, question_id: questions[3].id },
                            { body: 'Check for packages not declared in package.json', correct: true, question_id: questions[4].id }
                        ])
user_history = UserHistory.create([
                                      { user: users[0].login, tests: tests[0].title, completed: true, users_id: users[0].id, tests_id: tests[0].id },
                                      { user: users[0].login, tests: tests[1].title, completed: true, users_id: users[0].id, tests_id: tests[1].id },
                                      { user: users[0].login, tests: tests[2].title, completed: false, users_id: users[0].id, tests_id: tests[2].id },
                                      { user: users[3].login, tests: tests[3].title, completed: false, users_id: users[1].id, tests_id: tests[3].id }
                                  ])