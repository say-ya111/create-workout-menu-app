class StaticPagesController < ApplicationController
  def home
    @sample_types = [
      Type.new(name: "腕立て伏せ"),
      Type.new(name: "スクワット"),
      Type.new(name: "懸垂"),
      Type.new(name: "腹筋"),
      Type.new(name: "ベンチプレス")
    ]
    @indiv_part_menu_samples = [
      Type.new(name: "胸トレ1"),
      Type.new(name: "胸トレ2"),
      Type.new(name: "胸トレ3"),
      Type.new(name: "胸トレ4"),
      Type.new(name: "胸トレ5"),

    ]
  end

  def about
  end
end
