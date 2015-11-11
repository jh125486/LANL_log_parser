json.(log_line, :id, :number, :message, :process, :pid, :comment, :priority, :timestamp, :created_at, :updated_at)
json.location node_log_line_path(log_line.node, log_line)
json.partial! 'models/node', node: log_line.node
