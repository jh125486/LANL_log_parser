class Log < ActiveRecord::Base
  has_many :log_lines

  def process_log_file(from = 0)
    index = -1
    File.foreach(file) do |line|
      index += 1
      next if index < from
      payload = LogLine.parse(line)
      node = Node.find_or_create_by(name: payload.delete(:node))
      payload[:node_id] = node.id
      payload[:number] = index
      log_lines.create payload
    end
  end
end
