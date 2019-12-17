module FlashHelper
  def flash_header
    if flash[:alert]
      render inline: "<%= content_tag :p, flash[:alert], class: 'flash alert' %><br>"
    elsif flash[:notice]
      render inline: "<%= content_tag :p, flash[:notice], class: 'notice' %><br>"
    end
  end
end
