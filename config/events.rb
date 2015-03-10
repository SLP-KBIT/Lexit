WebsocketRails::EventMap.describe do
  subscribe :enter, to: SessionSyncController, with_method: :enter
  subscribe :leave, to: SessionSyncController, with_method: :leave

  namespace :websocket_rails do
    subscribe :subscribe_private, to: SessionSyncController, with_method: :authorize_channels
  end
end
