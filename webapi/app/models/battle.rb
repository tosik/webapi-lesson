class Battle

  def initialize(boss=nil)
    resume(boss)
  end

  def resume(boss)
    @boss = boss
  end

  def start
    @boss = Boss.create
    @boss.init!
    @boss.activities.create(text: "ボス　が　あられた")
  end

  def update
    @boss.update
  end

  def attack(character)
    damage = character.attack(@boss)
    if character.live?
      @boss.activities.create(text: "#{character.name}　のこうげき！\nボス　は #{damage} ダメージをうけた！")
    else
      @boss.activities.create(text: "#{character.name}　のこうげき！\nしかし　#{character.name}　はすでに　しんでいる")
    end

    character.save
    @boss.save

    attack_from_boss
  end

  def heal(from, to)
    unless from.healer?
      @boss.activities.create(text: "#{from.name}　のヒール！\nしかし　#{from.name}　はヒーラーではなかった")
      attack_from_boss
      return
    end
    if from.dead?
      @boss.activities.create(text: "#{from.name}　のヒール！\nしかし　#{from.name}　はすでに　しんでいる")
      attack_from_boss
      return
    end

    if to.present?
      from.heal(to)
    else
      @boss.activities.create(text: "#{from.name}　のヒール！\nしかし　あいてはこのよに　いない！")
    end

    to.try(:save)
    from.try(:save)

    attack_from_boss
  end

  def attack_from_boss
    result = @boss.attack!
    target_character = result[:target]
    damage = result[:damage]
    if target_character.present?
      @boss.activities.create(text: "ボス　のこうげき！\n#{target_character.name}　は #{damage} ダメージをうけた！")
    else
      @boss.activities.create(text: "ボス　のこうげき！\nしかし　あいては　すでに　しんでいる")
    end
  end

end
