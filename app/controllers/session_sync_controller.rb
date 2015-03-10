class SessionSyncController < WebsocketRails::BaseController
  def enter
    return unless message[:user][:id] != current_user.id
    @seminar_session = SeminarSession.find(message[:channel].gsub(/session/, '').to_i)
    return unless @seminar_session
    channel = WebsocketRails[message[:channel]]
    presentator = false
    presentator = true if @seminar_session.user_id == current_user.id
    channel.trigger :notify_enter, user: current_user.schema, presentator: presentator
  end

  def leave
    return unless message[:user][:id] != current_user.id
    channel = WebsocketRails[message[:channel]]
    channel.trigger :notify_leave, user: current_user.schema
  end

  def authorize_channels
    @seminar_session = SeminarSession.find(message[:channel].gsub(/session/, '').to_i)
    return unless @seminar_session
    if current_user.nil?
      deny_channel(message: 'Unauthorized.')
      return
    end

    channel = WebsocketRails[message[:channel]]
    channel.make_private unless channel.is_private?

    # TODO: セッションに参加しているユーザかどうかを判定し、deny or accept 処理を行う。
    accept_channel(user: current_user.schema)
    presentator = false
    presentator = true if @seminar_session.user_id == current_user.id
    channel.trigger :notify_enter, user: current_user.schema, presentator: presentator
  end
end
