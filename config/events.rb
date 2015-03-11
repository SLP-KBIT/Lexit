WebsocketRails::EventMap.describe do
  subscribe :enter, to: SessionSyncController, with_method: :enter
  subscribe :leave, to: SessionSyncController, with_method: :leave
  subscribe :set_slide, to: SessionSyncController, with_method: :set_slide

  namespace :websocket_rails do
    subscribe :subscribe_private, to: SessionSyncController, with_method: :authorize_channels
  end
end
