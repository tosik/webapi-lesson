class BattleController < ApplicationController

  def create_character
    raise "job が設定されていません" if params[:job].nil?
    if current_user.character.present? && current_user.character.live?
      raise "キャラクターがまだ生きています"
    end

    current_user.create_character(job: params[:job])
    boss.activities.create(text: "キャラクター #{character.name} が　たんじょうした！")
    render json: {
      character_id: character.id,
      characters: characters,
      activities: Activity.all.map(&:text),
    }
  end

  def attack
    battle.attack(character)

    render json: {
      characters: characters,
      activities: Activity.all.map(&:text),
    }
  end

  def heal
    target = Character.where(id: params[:target_id]).first
    battle.heal(character, target)

    render json: {
      characters: characters,
      activities: Activity.all.map(&:text),
    }
  end


  private

  def battle
    @battle ||= Battle.new(boss)
  end

  def boss
    @boss ||= Boss.first # FIXME: ボスが複数存在できない
  end

  def character
    @character ||= current_user.character
  end

  def current_user
    @current_user ||= User.find_by(session_id: session_id)
  end

  def session_id
    params[:session_id]
  end

  def characters
    Character.living.map(&:to_json)
  end

end
