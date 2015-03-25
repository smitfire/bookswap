require "faker"

User.destroy_all
Book.destroy_all
Vote.destroy_all

lat_arr = [40.71, 39.62, 41.45, 44.1, 45.15]
long_arr = [-100.23, -93.23, -101.23, -105.23, -98.23]

10.times do
  u=User.create!(email: Faker::Internet.email, password: "nickpass", password_confirmation: "nickpass", longitude: long_arr.sample, latitude: lat_arr.sample, range: Faker::Number.between(1,50) )
  10.times do
    u.owned_books.create( author: Faker::Lorem.word, summary: Faker::Lorem.paragraph(3) )
  end
end

yay = [true, false]

20.times do
  offset_u = rand(User.count)
  offset_b = rand(User.count)
  u= User.offset(offset_u).first
  b= Book.offset(offset_b).first
  if u.voted_books.exists?(b)
    u.voted_books << b
    v = u.votes.last
    v.liked = yay.sample
    v.save
  end
end