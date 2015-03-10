//= require websocket_rails/main

class @SyncSession
  connected: false
  reconnectDelay: 5000
  pool: []
  sessions: []
  connectedSendPool: []

  constructor: (url, channel) ->
    @dispatcher = new WebSocketRails(url)
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'connection_closed', @onDisconnect
    @dispatcher.on_open = @onConnect
    @dispatcher.bind 'enter', @onEnter
    @dispatcher.bind 'leave', @onLeave

  onDisconnect: =>
    @connected = false
    @reconnect()

  isConnected: =>
    return @connected

  reconnect: =>
    @dispatcher.disconnect()
    setTimeout( =>
      @reconnectDelay = 5000
      @dispatcher.reconnect()
    , @reconnectDelay )

  onConnect: =>
    @connected = true
    @dispatcher.trigger( 'connect', {} )
    if @currentSessionId?
      @enterSession( @currentSessionId )
    @sendPool()

  enterSession: ( session_id ) =>
    return if @sessions[ session_id ]?
    @sessions[ session_id ] = @dispatcher.subscribe_private( 'session' + session_id )
    @sessions[ session_id ].on_success = ( user ) =>
      @sessions[ session_id ].bind 'enter', @onEnter
      @sessions[ session_id ].bind 'leave', @onLeave
    @sessions[ session_id ].on_failure = ( reason ) ->
      console.log JSON.stringify( reason )
      if reason.message == 'Unauthorized.'
        alert 'Unauthorized.'
    return

  sendPool: =>
    for send_pool in @connectedSendPool
      console.log 'Send by pool. => ' + JSON.stringify( send_pool.data )
      @dispatcher.trigger( send_pool.event, send_pool.data )
    @connectedSendPool = []


  onEnter: (e) =>
    console.log(e)

  onLeave: (e) =>
    console.log(e)


window.syncSessionClass = new SyncSession(window.location.host + '/websocket')
