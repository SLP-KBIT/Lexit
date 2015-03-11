@addMember = (user, presentator) ->
  return if $('ul.member li[data-user-id=' + user.id + ']').length > 0
  li = $('<li>').attr('data-user-id', user.id).text(user.name_with_student_code)
  li.addClass('presentator') if presentator
  $('ul.member').append(li)


@removeMember = (user) ->
  $('ul.member li[data-user-id=' + user.id + ']').remove()


@slideToNext = ->
  currentIndex = $('.slide > img').length
  for img, index in $('.slide > img')
    break if $('.slide > img').length - 1 == index
    if $(img).css('display') != 'none'
      $(img).addClass('hide')
      $($('.slide > img')[index + 1]).removeClass('hide')
      currentIndex = index + 2
      break
  $('.slide-info').text(currentIndex + '/' + $('.slide > img').length)
  if window.presentator
    syncSessionClass.sendPage(currentIndex)


@slideToPrev = ->
  currentIndex = 1
  for img, index in $('.slide > img')
    continue if 0 == index
    if $(img).css('display') != 'none'
      $(img).addClass('hide')
      $($('.slide > img')[index - 1]).removeClass('hide')
      currentIndex = index
      break
  $('.slide-info').text(currentIndex + '/' + $('.slide > img').length)
  if window.presentator
    syncSessionClass.sendPage(currentIndex)


@showSlideController = ->
  $('.btn-slide-next,.btn-slide-prev').show()

@hideSlideController = ->
  $('.btn-slide-next,.btn-slide-prev').hide()


@toggleCommentList = (show = true) ->
  $('.comment-container').transit({ x: (if show then 0 else '100%') }, 300)
  $('.slide').transit({ width: (if show then '80%' else '100%') }, 300)
  $('.slide-controller').transit({ right: (if show then '20%' else 0) }, 300)
  if show
    $('#btn-toggle-comment').text('コメントを隠す')
  else
    $('#btn-toggle-comment').text('コメントを表示する')
  setTimeout( @adjustSlideSize, 350 )


@toggleCommentInput = (show = true) ->
  $('.comment-input-container').transit({ height: (if show then '80px' else 0) }, 300)
  if show
    $('#btn-toggle-comment-input').text('コメントをやめる')
  else
    $('#btn-toggle-comment-input').text('コメントする')


@adjustSlideSize = ->
  return if $('.slide > img').length <= 0
  slide_w = $('.slide > img').width()
  container_w = $('.slide').width()
  if container_w <= 640
    slide_h = $('.slide > img').height()
    slide_h = slide_h * ( container_w / slide_w )
    $('.slide > img').width(container_w)
    $('.slide > img').height(slide_h)
    pad_h = ( $('.slide').outerHeight() - slide_h ) / 2
    $('.slide').css('padding', pad_h + 'px 0')
  else
    $('.slide > img').width('auto').height('480px')
    $('.slide').css('padding', '10px 0')

$(window).on('resize', @adjustSlideSize)
$(window).on('load page:load', @adjustSlideSize)


