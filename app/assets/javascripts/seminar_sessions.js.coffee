@addMember = (user) ->
  return if $('ul.member li[data-user-id=' + user.id + ']').length > 0
  $('ul.member').append($('<li>').attr('data-user-id', user.id).text(user.name_with_student_code))


@removeMember = (user) ->
  $('ul.member li[data-user-id=' + user.id + ']').remove()
