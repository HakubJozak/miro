module IconHelper

  def icon(name, title = nil, klass: nil)
    i = "<i class='fa fa-#{name} #{klass}'></i>"
    [ i, title ].compact.join(' ').html_safe
  end

  def icon_with_tooltip(name, title, tooltip)
    %(<i class="fa fa-#{name} popover-me" title="#{title}" data-content="#{tooltip}"></i>).html_safe
  end

end
