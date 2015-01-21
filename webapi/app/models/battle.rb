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
    update
    damage = character.attack(@boss)
    if character.live?
      @boss.activities.create(text: "#{character.name}　のこうげき！\nボス　は #{damage} ダメージをうけた！")
    else
      @boss.activities.create(text: "#{character.name}　のこうげき！\nしかし　#{character.name}　はすでに　しんでいる")
    end

    character.save
    @boss.save

    record_dying_activity
    attack_from_boss
  end

  def heal(from, to)
    update
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
      recovered_points = from.heal(to)
      @boss.register_as_hate(from, recovered_points * 3)

      @boss.activities.create(text: "#{from.name}　のヒール！\n#{from.name}　は #{recovered_points} かいふくした")
    else
      @boss.activities.create(text: "#{from.name}　のヒール！\nしかし　あいてはこのよに　いない！")
    end

    to.try(:save)
    from.try(:save)

    record_dying_activity
    attack_from_boss
  end

  def attack_from_boss
    result = @boss.attack!
    target_character = result[:target]
    damage = result[:damage]
    if target_character.present?
      @boss.activities.create(text: "ボス　のこうげき！\n#{target_character.name}　は #{damage} ダメージをうけた！")
      if target_character.dead?
        @boss.activities.create(text: "#{target_character.name}　は　しんでしまった！")
      end
    else
      @boss.activities.create(text: "ボス　のこうげき！\nしかし　あいては　すでに　しんでいる")
    end
  end

  def self.restart
    Activity.destroy_all
    Boss.destroy_all
    Character.destroy_all
    Battle.new.start
  end

  def record_dying_activity
    if @boss.dead?
      @boss.activities.create(text: "ボス　をたおした！！")
    end
  end

end
