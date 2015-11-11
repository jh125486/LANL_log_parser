module BootstrapHelpers
  include BootstrapBtnHelpers

  ALERT_ICONS = {
    success: 'ok-sign',
    info: 'info-sign',
    warning: 'question-sign',
    danger: 'alert'
  }

  def bs_nav_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options, options, name = options, name, block if block_given?
    options ||= {}
    html_options = convert_options_to_data_attributes(options, html_options)
    url = url_for(options)
    html_options['href'] ||= url
    nav_class = 'active' if active_link? url, html_options.delete('active')
    nav_class = 'disabled' if html_options.delete('disabled')
    content_tag(:li, class: nav_class) do
      content_tag(:a, name || url, html_options, &block)
    end
  end

  def bs_button_dropdown(button_text, opts = {})
    button_id = opts[:id] ||= SecureRandom.uuid
    btn_class = "btn btn-#{opts[:context] || 'default'} dropdown-toggle"
    html_options = { data: { toggle: 'dropdown' }, aria: { haspop: 'true', expanded: 'false' } }
    content_tag(:div, class: 'dropdown') do
      button_tag(html_options.merge class: btn_class, type: 'button', id: button_id) do
        button_text + caret
      end + dropdown_menu(button_id, opts, &Proc.new)
    end
  end

  def bs_alert(kind = :success, columns = 4, &block)
    kind = :success unless ALERT_ICONS.keys.include?(kind)
    columns = 12 if columns < 0 || columns > 12
    css_alert_classes = "alert alert-#{kind} alert-dismissible"
    css_text_classes  = 'text-info text-center'
    css_col_classes   = "col-md-#{columns} col-md-offset-#{(12 - columns) / 2}"

    content_tag(:div, class: [css_alert_classes, css_text_classes, css_col_classes]) do
      content_tag(:button, times, type: 'button', class: 'close', data: { dismiss: 'alert' }) +
        bs_glyph(ALERT_ICONS[kind], aria: { hidden: 'true' }, class: 'pull-left') +
        content_tag(:span, kind, class: 'sr-only') + capture(&block)
    end
  end

  def bs_navbar_dropdown(menu_text, opts = {})
    menu_id = SecureRandom.uuid
    data = { toggle: 'dropdown' }
    aria = { haspop: 'true', expanded: 'false' }
    content_tag(:li, class: "dropdown #{opts.delete :dropdown_class}") do
      link_to('#', class: 'dropdown-toggle', data: data, id: menu_id, role: 'button', aria: aria) do
        content_tag(:span, menu_text) + caret
      end + dropdown_menu(menu_id, opts, &Proc.new)
    end
  end

  def bs_badge(count, opts = {})
    return unless count
    css_class = opts[:class]
    content_tag :span, count, opts.merge(class: "badge #{css_class}")
  end

  def bs_glyph(glyph, opts = {})
    return unless glyph
    css_class = opts[:class]
    [
      content_tag(:span, nil, opts.merge(class: "glyphicon glyphicon-#{glyph} #{css_class}")),
      opts[:text]
    ].compact.join(' ').html_safe
  end

  def bs_label(kind, text, opts = {})
    return unless kind && text
    css_class = opts[:class]
    content_tag :span, text, opts.merge(class: "label label-#{kind} #{css_class}")
  end

  def bs_popover(content, text = nil, opts = {})
    text ||= '&hellip;'.html_safe
    data = { container: 'body', toggle: 'popover', placement: 'auto', trigger: 'focus', content: content }
    default_opts = { class: 'btn btn-link', data: data, tabindex: '0' }
    content_tag :button, text, default_opts.deep_merge(opts)
  end

  def dropdown_item(item)
    if item.is_a? String
      content_tag(:li, item)
    elsif item.eql? :separator
      content_tag(:li, nil, class: 'divider', role: 'separator')
    elsif item[:header]
      content_tag(:li, item[:header], class: 'dropdown-header')
    elsif item[:disabled]
      content_tag(:li, item[:disabled], class: 'disabled')
    end
  end

  private

  def caret
    content_tag :span, nil, class: 'caret'
  end

  def times
    content_tag :span, '&times;'.html_safe
  end

  def dropdown_menu(labelledby, opts = {})
    ul_classes = "dropdown-menu #{opts[:menu_class]}"
    ul_classes += 'dropdown-menu-right' if opts[:pull_right]
    content_tag(:ul, class: ul_classes, aria: { labelledby: labelledby }) do
      yield
    end
  end
end
