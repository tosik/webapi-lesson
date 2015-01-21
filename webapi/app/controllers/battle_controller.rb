class BattleController < ApplicationController

  def create_character
    raise "job が設定されていません" if params[:job].nil?
    if current_user.character.present? && current_user.character.live?
      raise "キャラクターがまだ生きています"
    end

    current_user.create_character(job: params[:job])
    render json: { character: character.to_json }
  end

  def attack
    battle.attack(character)

    render json: { character: character.to_json, characters: characters }
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
