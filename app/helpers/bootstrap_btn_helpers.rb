module BootstrapBtnHelpers
  def new_crud_btn(klass)
    return if klass.nil?
    link_to t('.new', default: t('helpers.links.new')),
            [:new, klass.name.underscore],
            class: 'btn btn-primary'
  end

  def action_btns(obj)
    edit_opts = { class: 'btn btn-default' }
    remove_opts = { method: :delete, data: { confirm: t('helpers.links.confirm') }, class: 'btn btn-danger' }
    content_tag(:div, class: 'btn-group btn-group-sm actions') do
      link_to(glyph('info-sign'), obj, class: 'btn btn-default', title: t('helpers.links.show')) +
        link_to(glyph('pencil'), [:edit, obj].flatten, edit_opts.merge(title: t('helpers.links.edit'))) +
        link_to(glyph('remove'), obj, remove_opts.merge(title: t('helpers.links.destroy')))
    end
  end

  def btn_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    btn_class = 'add_fields btn btn-success'
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render association.to_s.singularize + '_fields', f: builder
    end
    button_tag type: 'button', class: btn_class, data: { id: id, fields: fields.gsub('\n', '') } do
      bs_glyph('plus', text: name)
    end
  end

  def btn_to_remove_fields(name, f)
    btn_class = 'remove_fields btn btn-warning'
    button_tag(type: 'button', class: btn_class) do
      bs_glyph('minus', text: name)
    end + f.hidden_field(:_destroy)
  end

  def confirm_to_remove_btn(opts = {})
    defaults = { class: 'btn btn-danger', type: 'button', title: t('helpers.links.confirm') }
    kind = opts.delete :kind
    defaults.merge! opts
    content = html_escape_once confirmation(kind)
    defaults.merge!(data: { toggle: 'popover', content: content, html: true, placement: 'left' })
    content_tag(:button, defaults) do
      block_given? ? yield : bs_glyph('remove')
    end
  end

  def confirm_btn(btn, opts = {}, &block)
    defaults = { class: 'btn btn-danger', type: 'button', title: t('helpers.links.confirm') }
    defaults.merge! opts
    content = html_escape_once capture(&block)
    defaults.merge!(data: { toggle: 'popover', content: content, html: true, placement: 'left' })
    content_tag :button, btn, defaults
  end

  private

  def confirmation(kind = nil)
    confirm_opts = { type: 'button', class: "btn btn-danger confirm #{kind}" }
    cancel_opts  = { type: 'button', class: 'btn btn-link pull-right close-popover' }
    button_tag(fa_icon('trash'), confirm_opts) + button_tag(t('helpers.links.cancel'), cancel_opts)
  end
end
