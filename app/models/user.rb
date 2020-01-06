class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :menus, dependent: :destroy
  has_many :menu_items, through: :menus, source: :type

  has_many :muscle_parts, dependent: :destroy

  def menu_of_recovered_parts
    menu = []
    self.menu_items.to_a.each do |item|
      if self.recovered_parts.include?(item.part)
        menu = item
      else
        next
      end
    end
    return menu
  end

  def recovered_parts
    self.muscle_parts.to_a.delete_if{|mp| !mp.is_recovered(Date.today)}.pluck(:part)
  end
end
