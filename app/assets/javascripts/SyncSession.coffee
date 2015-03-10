//= require websocket_rails/main

class @SyncSession
  connected: false
  reconnectDelay: 5000
  pool: []
  sessions: []
  connectedSendPool: []
  currentSessionId: null

  constructor: (url, channel) ->
    @dispatcher = new WebSocketRails(url)
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'connection_closed', @onDisconnect
    @dispatcher.on_open = @onConnect

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
    @currentSessionId = session_id
    return if @sessions[ session_id ]?
    @sessions[ session_id ] = @dispatcher.subscribe_private( 'session' + session_id )
    @sessions[ session_id ].on_success = ( user ) =>
      console.log('Connected to session: [' + session_id + ']')
      @sessions[ session_id ].bind 'notify_enter', @onEnter
      @sessions[ session_id ].bind 'notify_leave', @onLeave
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
    addMember(e.user)

  onLeave: (e) =>
    removeMember(e.user)
    if e.user.id == window.user_id
      @dispatcher.unsubscribe( 'session' + @currentSessionId )
      @sessions[@currentSessionId] = null

  leave: =>
    @sessions[@currentSessionId].trigger("notify_leave",{ user: { id: window.user_id } })


window.syncSessionClass = new SyncSession(window.location.host + '/websocket')
