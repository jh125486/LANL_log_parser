class Datatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :mail_to, :action_btns, :nice_link_to, :row_id, :simple_format,
                 :timestamp, :livestamp, :t, :editable

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= []
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= sortable_columns
  end

  private

  # rubocop:disable Style/AccessorMethodName
  def get_raw_records
    options[:collection]
  end
  # rubocop:enable Style/AccessorMethodName
end
