class Boss < ActiveRecord::Base
  has_many :activities

  serialize :hate_table

  def max_hp
    10000
  end

  def receive_damage(damage, from)
    reduce_hp(damage)
    register_as_hate(from, damage)
  end

  def reduce_hp(damage)
    self.hp -= damage
  end

  def dead?
    hp <= 0
  end

  def register_as_hate(from, damage)
    hate_table[from.id] ||= 0
    hate_table[from.id] += damage
  end

  def update
    update_hate_table
  end

  def reduce_hate
    hate_table.each_key do |key|
      hate_table[key] /= 2
    end
  end

  def update_hate_table
    hate_table.keys.each do |character_id|
      hate_table.delete(character_id) if Character.find(character_id).dead?
    end
  end

  def choose_target
    update_hate_table
    sorted = hate_table.sort {|(ka, va), (kb, vb)| va <=> vb }
    if sorted.first.present?
      Character.find(sorted.first.first)
    else
      nil
    end
  end

  def attack!
    character = choose_target
    if character.present?
      damage = Random.rand(power)
      character.receive_damage(damage)
      character.save
    end

    { target: character, damage: damage || 0 }
  end

  def power
    (50..100)
  end

  def maximize_hp
    self.hp = max_hp
  end

  def to_json
    { hp: hp, max_hp: max_hp }
  end

  def init!
    maximize_hp
    self.hate_table = {}
    save
  end

end
