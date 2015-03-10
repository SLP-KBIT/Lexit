@addMember = (user, presentator) ->
  return if $('ul.member li[data-user-id=' + user.id + ']').length > 0
  li = $('<li>').attr('data-user-id', user.id).text(user.name_with_student_code)
  li.addClass('presentator') if presentator
  $('ul.member').append(li)


@removeMember = (user) ->
  $('ul.member li[data-user-id=' + user.id + ']').remove()
