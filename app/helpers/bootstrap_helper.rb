module BootstrapHelper

  def li_link_to(title, path, opts = {})
    klass = 'active' if request.path == path
    content_tag :li, class: klass do
      link_to title, path, opts
    end
  end

  def btn_to_js(title,opts = {})
    opts = opts.merge class: 'btn btn-default'
    link_to title, '#', opts
  end

  def tab_href(record)
    "##{dom_id(record)}"
  end

  def panel(title = nil,opts = {},&block)
    vars = { title: title }

    if block_given?
      if opts.delete(:table)
        vars[:table] = capture(&block)
      else
        vars[:body] = capture(&block)
      end
    end

    vars[:opts] = opts
    render partial: 'blueprint/panel', locals: vars
  end

  def dropdown(links)
    if links.empty?
      return
    elsif links.size == 1
      main = links.first
      link_to main.title, main.url, main.opts.merge(class: 'btn btn-default btn-sm')
    else
      main = links.shift
      render partial: 'blueprint/dropdown', locals: {
               main: main,
               links: links
             }
    end
  end

  def progress_bar(value,text = nil)
    render partial: 'blueprint/progress_bar', locals: {
             progress: value,
             text: text
           }
  end

  def fieldset(legend = nil,&block)
    text = capture(&block)
    render 'blueprint/fieldset', legend: legend, body: text
  end

end
