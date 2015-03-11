@addMember = (user, presentator) ->
  return if $('ul.member li[data-user-id=' + user.id + ']').length > 0
  li = $('<li>').attr('data-user-id', user.id).text(user.name_with_student_code)
  li.addClass('presentator') if presentator
  $('ul.member').append(li)


@removeMember = (user) ->
  $('ul.member li[data-user-id=' + user.id + ']').remove()


@slideToNext = ->
  for img, index in $('.slide img')
    break if $('.slide img').length - 1 == index
    if $(img).css('display') != 'none'
      $(img).addClass('hide')
      $($('.slide img')[index + 1]).removeClass('hide')
      break


@slideToPrev = ->
  for img, index in $('.slide img')
    continue if 0 == index
    if $(img).css('display') != 'none'
      $(img).addClass('hide')
      $($('.slide img')[index - 1]).removeClass('hide')
      break


@toggleCommentList = (show = true) ->
  $('.comment-container').transit({ x: (if show then 0 else '100%') }, 300)
  $('.slide').transit({ width: (if show then '80%' else '100%') }, 300)
  $('.slide-controller').transit({ right: (if show then '20%' else 0) }, 300)
  if show
    $('#btn-toggle-comment').text('コメントを隠す')
  else
    $('#btn-toggle-comment').text('コメントを表示する')


@toggleCommentInput = (show = true) ->
  $('.comment-input-container').transit({ height: (if show then '80px' else 0) }, 300)
  if show
    $('#btn-toggle-comment-input').text('コメントをやめる')
  else
    $('#btn-toggle-comment-input').text('コメントする')

