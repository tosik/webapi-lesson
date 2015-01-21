class LoginController < ApplicationController

  def create
    firsttime = User.where(name: username).blank?
    user = User.where(name: username).first_or_create
    user.session_id = random_session_id
    user.save
    session[:user_id] = user.id
    session[:session_id] = user.session_id

    render json: {
      session_id: user.session_id,
      character: user.character.try(:to_json),
      boss: Boss.first.to_json
    }
  end

  def username
    params[:username]
  end

  def random_session_id
    id = rand(1000)
    if User.where(session_id: id).empty?
      id
    else
      random_session_id
    end
  end

end
