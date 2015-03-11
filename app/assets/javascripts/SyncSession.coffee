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
      @sessions[ session_id ].bind 'set_slide', @onSetSlide
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
    addMember(e.user, e.presentator)
    if e.user.id == window.user_id && e.presentator
      showSlideController()
      window.presentator = true
    else
      hideSlideController()
      window.presentator = false

  onLeave: (e) =>
    removeMember(e.user)
    if e.user.id == window.user_id
      @dispatcher.unsubscribe( 'session' + @currentSessionId )
      @sessions[@currentSessionId] = null

  onSetSlide: (e) =>
    $('.slide > img').addClass('hide')
    $($('.slide > img')[e.page - 1]).removeClass('hide')
    $('.slide-info').text(e.page + '/' + $('.slide > img').length)

  leave: =>
    @sessions[@currentSessionId].trigger('notify_leave', { user: { id: window.user_id } })

  sendPage: (page) =>
    @sessions[@currentSessionId].trigger('set_slide', { user: { id: window.user_id }, page: page })

window.syncSessionClass = new SyncSession(window.location.host + '/websocket')
