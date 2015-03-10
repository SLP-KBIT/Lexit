module PreparationsHelper
  def flag_td(flag)
    return content_tag('td', class: 'success') if flag
    content_tag('td', class: 'danger')
  end
end
