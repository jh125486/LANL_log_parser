json.(node, :id, :name, :created_at, :updated_at)
json.location node_path(node)
json.log_lines node_log_lines_path(node)
