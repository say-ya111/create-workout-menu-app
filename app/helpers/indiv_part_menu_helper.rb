module IndivPartMenuHelper
  # 次の分割メニューに取り組む際のアドバイスを表示する
  def guide_of_next_split_menu(user)
    case user.times_a_week
    when 2
      "週に2回トレーニングする方の分割メニューです。3~4日のオフをとるのがおすすめです。"
    when 3, 4
      "週に3~4回トレーニングする方の分割メニューです。1~2日のオフをとるのがおすすめです。"
    end
  end
end
