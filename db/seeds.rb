# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MULTIPLIER = 2
QUESTIONS = ['How much do you like dogs?', 
             'How much do you like cats?',
             'How much do you like snakes?',
             'How much do you like sandwiches?',
             'How much do you like reading?']

def create_user
  u = User.new
  u[:first_name] = Faker::Name.first_name
  u[:last_name] = Faker::Name.last_name
  u[:email] = Faker::Internet.email
  u[:age] = (18..65).to_a.sample
  u[:gender] = ['male', 'female', 'other'].sample
  u.save!
end

def generate_questions
  QUESTIONS.each do |question|
    q = Question.new
    q[:body] = question
    q.save!
  end
end

def generate_responses(user)
  r = Response.new
  r.user_id = user.id
  r.question_id = Question.pluck(:id).sample
  r.value = (1..5).to_a.sample
  r.save!
end

puts "Destroying old data"

User.destroy_all
Response.destroy_all
Question.destroy_all

puts "Old data destroyed"

puts "Generating users"

(5 * MULTIPLIER).times do
  create_user
end

puts "Generating questions"

generate_questions

puts "Generating user responses"

User.all.each do |user|
  2.times do
    generate_responses(user)
  end
end

puts "Done!"