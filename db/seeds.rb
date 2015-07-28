require "faker"

User.destroy_all
Book.destroy_all
Vote.destroy_all

lat_arr = [40.71, 39.62, 41.45, 44.1, 45.15]
long_arr = [-100.23, -93.23, -101.23, -105.23, -98.23]

10.times do
  u=User.create!(email: Faker::Internet.email, password: "nickpass", password_confirmation: "nickpass", longitude: long_arr.sample, latitude: lat_arr.sample, range: Faker::Number.between(10000,50000) )
  10.times do
    u.owned_books.create( author: Faker::Lorem.word, summary: Faker::Lorem.paragraph(3) )
  end
end

yay = [true, false]

10.times do
  u = User.all.sample
  bs = u.bookstack  
  # while u.owned_books.exists?(b) or u.voted_books.exists?(b)
  5.times do
    b = bs.sample
    if b and !u.votes.exists?(book_id: b.id)
      v = u.votes.create(liked: yay.sample, book_id: b.id)
    end
  end


end