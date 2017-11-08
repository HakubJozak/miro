# coding: utf-8
class MenuCell < Cell::ViewModel
  include Escaped
  include ActionView::Helpers::UrlHelper
  include BootstrapHelper
  include IconHelper  

  property :name

  def show
    render
  end

  private

  def logout_link
    li_link_to "Odhlásit", destroy_user_session_path
  end

  def logo
    icon 'paint-brush'
  end


end
