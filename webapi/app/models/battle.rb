class Battle

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
