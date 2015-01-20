class Character < ActiveRecord::Base
  belongs_to :user

  def attack(boss)
    boss.receive_damage(power.sample, self)
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

end
