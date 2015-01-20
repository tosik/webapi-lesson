class Boss < ActiveRecord::Base

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
    Character.find(hate_table.sort {|(ka, va), (kb, vb)| va <=> vb }.first.first)
  end

  def attack
    character = choose_target
    character.receive_damage(power.sample)
  end

  def power
    (50..100)
  end

end
