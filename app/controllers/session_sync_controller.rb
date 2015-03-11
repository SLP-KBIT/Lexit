class SessionSyncController < WebsocketRails::BaseController
  def enter
    return unless authenticate_user_and_channel
    presentator = false
    presentator = true if @seminar_session.user_id == current_user.id
    @channel.trigger :notify_enter, user: current_user.schema, presentator: presentator
  end

  def leave
    return unless authenticate_user_and_channel
    @channel.trigger :notify_leave, user: current_user.schema
  end

  def authorize_channels
    if current_user.nil? || !authenticate_user_and_channel
      deny_channel(message: 'Unauthorized.')
      return
    end

    @channel.make_private unless @channel.is_private?

    accept_channel(user: current_user.schema)
    presentator = (@seminar_session.user_id == current_user.id)
    @channel.trigger :notify_enter, user: current_user.schema, presentator: presentator
  end

  private

  def authenticate_user_and_channel
    # TODO: セッションに参加しているユーザかどうかを判定し、deny or accept 処理を行う。
    return false if message[:user] && message[:user][:id].to_i != current_user.id
    seminar_session_id = message[:channel].gsub(/session/, '').to_i
    @seminar_session = SeminarSession.find(seminar_session_id)
    return false unless @seminar_session
    @channel = WebsocketRails[message[:channel]]
    true
  end
end
