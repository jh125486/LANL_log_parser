class NodesDatatable < Datatable
  private

  def sortable_columns
    @sortable_columns ||= %w(
      Node.name
      Node.created_at
      Node.updated_at
    )
  end

  def searchable_columns
    sortable_columns
  end

  def data
    records.map do |node|
      {
        '0' => nice_link_to(node),
        '1' => livestamp(node.created_at),
        '2' => livestamp(node.updated_at),
        '3' => action_btns(node),
        'DT_RowId' => row_id(node)
      }
    end
  end
end
