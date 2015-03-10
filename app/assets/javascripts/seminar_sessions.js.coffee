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

