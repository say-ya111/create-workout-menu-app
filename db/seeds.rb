# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ["ベンチプレス", "スクワット", "デッドリフト", "ラットプルダウン", "ダンベルカール"]

names.each do |name|
  Type.create(name: name)
end

10.times do |n|
  user = User.create!(email: "valid#{n}@mail.com", password: "foobar", password_confirmation: "foobar")
  
  # userのidで種目を分岐
  if n + 1 % 2 == 0
    # idが偶数のユーザーはベンチプレス、スクワット、デッドリフトでメニューを構成
    types_of_even_user = Type.all[0..2]
    types_of_even_user.each do |t|
      user.menus.create!(type_id: t.id)
    end
  else
    # idが偶数のユーザーはラットプルダウン、ダンベルカールでメニューを構成
    types_of_odd_user = Type.all[3..4]
    types_of_odd_user.each do |t|
      user.menus.create!(type_id: t.id)
    end
  end
end