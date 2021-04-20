# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ["ベンチプレス", "スクワット", "デッドリフト", "ラットプルダウン", "ダンベルカール", "レッグエクステンション", "レッグカール", "ヒップリフト", "ショルダープレス"]

parts = ["大胸筋", "脚", "背筋", "広背筋", "上腕二頭筋", "大腿四頭筋", "ハムストリング", "ヒップ", "肩"]

names.zip(parts) do |name, part|
  Part.create!(name: part)
  Type.create!(name: name, part_id: Part.find_by(name: part).id)
end

10.times do |n|
  user = User.create!(email: "valid#{n}@mail.com", password: "foobar", training_rotation: 0, times_a_week: 2, password_confirmation: "foobar")
  
  # userのidで種目を分岐
  if user.id % 2 == 0
    # idが偶数のユーザーはベンチプレス、スクワット、デッドリフト、レッグエクステンション、ヒップリフトでメニューを構成
    user.add_type_to_menu([1, 2, 3, 6, 8])
  else
    # idが奇数のユーザーはラットプルダウン、ダンベルカール、レッグカール、ショルダープレスでメニューを構成
    user.add_type_to_menu([4, 5, 7, 9])
  end
end