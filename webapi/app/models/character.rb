class Character < ActiveRecord::Base
  belongs_to :user

  def attack(boss)
    boss.receive_damage(Random.rand(power), self)
  end

  def power
    status[:power]
  end

  def status
    {
      fighter: {
        power: (100..200),
        max_hp: 300,
      },
      healer: {
        power: (20..40),
        max_hp: 100,
      },
      magician: {
        power: (200..500),
        max_hp: 120,
      }
    }[job.to_sym]
  end

  def dead?
    hp <= 0
  end

  def heal(target)
    target.recover(100)
  end

  def recover(point)
    self.hp += point
    self.hp = max_hp if hp > max_hp
  end

  def max_hp
    status[:max_hp]
  end

  def receive_damage(damage)
    self.hp -= damage
  end

  def healer?
    job == "healer"
  end

  def fighter?
    job == "fighter"
  end

  def magician?
    job == "magician"
  end

end
