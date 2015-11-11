class LogLinesDatatable < Datatable
  private

  def sortable_columns
    @sortable_columns ||= %w(
      LogLine.number
      LogLine.message
      LogLine.comment
      LogLine.priority
      LogLine.timestamp
    )
  end

  def searchable_columns
    sortable_columns
  end

  def data
    records.map do |log_line|
      {
        '0' => log_line.number,
        '1' => log_line.message,
        '2' => editable([log_line.node, log_line], :comment),
        '3' => editable([log_line.node, log_line], :priority, type: 'select', source: ['', 1, 2, 3, 4, 5]),
        '4' => log_line.timestamp.iso8601,
        '5' => action_btns([log_line.node, log_line]),
        'DT_RowId' => row_id(log_line)
      }
    end
  end
end
