module SessionsHelper
  def flash_header
    if flash[:alert]
      render inline: "<br><%= content_tag :p, flash[:alert], class: 'flash alert' %><br>"
    elsif flash[:notice]
      render inline: "<br><%= content_tag :p, flash[:notice], class: 'notice' %>"
    end
  end
end

