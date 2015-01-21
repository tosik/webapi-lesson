class Battle

  def initialize(boss=nil)
    resume(boss)
  end

  def resume(boss)
    @boss = boss
  end

  def start
    @boss = Boss.create
  end

  def update
    @boss.update
  end

  def attack(character)
    character.attack(@boss)

    character.save
    @boss.save

    @boss.attack!
  end

  def heal(from, to)
    # log unless from.healer?
    # log unless from.dead?

    if to.present?
      from.heal(to)
    else
      # log
    end

    to.save
    from.save

    @boss.attack!
  end

end
