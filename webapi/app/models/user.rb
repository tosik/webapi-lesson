class User < ActiveRecord::Base

  has_one :character

  def create_character(attributes)
    character = Character.create(attributes)
    character.maximize_hp
    self.character = character
    self.save
  end

end
