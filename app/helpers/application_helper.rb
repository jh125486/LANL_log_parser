module ApplicationHelper
  include BootstrapHelpers

  def check_or_not(bool)
    glyph = bool ? glyph('ok') : glyph('minus')
    content_tag(:span, bool, class: 'hidden') + glyph
  end

  def timestamp(time)
    return unless time
    content_tag :span, time.iso8601, class: 'timestamp'
  end

  def livestamp(time)
    return unless time
    content_tag(:span, nil, class: 'text-nowrap', data: { livestamp: time.iso8601 })
  end

  def nice_link_to(obj, opts = {})
    return if obj.nil?
    link_to obj.to_s, obj.becomes(obj.class.base_class), opts
  end

  def row_id(obj)
    "#{obj.class.name.underscore}_#{obj.id}"
  end

  def truncate_to_popover(text)
    bs_popover(text, glyph('eye-open'))
  end

  def label_with_value(label, value, opts = {})
    opts[:label_context] ||= 'default'
    content_tag(:dt, label, class: "label label-#{opts[:label_context]}") +
      content_tag(:dd, content_tag(:pre, value, class: 'prettyprint'))
  end

  def array_to_ul(arr = [], opts = {})
    content_tag(:ul, class: opts[:ul_class]) do
      arr.map do |el|
        content_tag(:li, el, class: opts[:li_class])
      end.join.html_safe
    end
  end

  def cancel_link
    link_to t('.cancel', default: t('helpers.links.cancel')), :back, class: 'btn btn-link pull-right'
  end

  def current_controller?(controller)
    controller_name == controller.to_s
  end

  def path_from(url)
    Rails.application.routes.recognize_path url
  end

  private

  def active_link?(url, condition = nil)
    case condition
    when TrueClass then true
    when FalseClass then false
    when Hash then condition.all? { |k, v| params[k].to_s.eql? v.to_s }
    when :current_controller then current_controller? path_from(url)[:controller]
    when nil then current_page? url
    end
  end
end
