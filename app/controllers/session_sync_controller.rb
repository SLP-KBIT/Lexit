class SessionSyncController < WebsocketRails::BaseController
  def enter
    return unless message[:user][:id] != current_user.id
    channel = WebsocketRails[message[:channel]]
    channel.trigger :notify_enter, user: current_user.schema
  end

  def leave
    return unless message[:user][:id] != current_user.id
    channel = WebsocketRails[message[:channel]]
    channel.trigger :notify_leave, user: current_user.schema
  end

  def authorize_channels
    if current_user.nil?
      deny_channel(message: 'Unauthorized.')
      return
    end

    channel = WebsocketRails[message[:channel]]
    channel.make_private unless channel.is_private?

    # TODO: セッションに参加しているユーザかどうかを判定し、deny or accept 処理を行う。
    accept_channel(user: current_user.schema)
    channel.trigger :notify_enter, user: current_user.schema
  end
end
