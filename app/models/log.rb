class Log < ActiveRecord::Base
  has_many :log_lines

  def process_log_file(from = 0)
    index = -1
    ActiveRecord::Base.transaction do
      File.foreach(file) do |line|
        index += 1
        next if index < from
        payload = LogLine.parse(line)
        node = Node.find_or_create_by(name: payload.delete(:node))
        log_lines.create payload.merge(node_id: node.id, number: index)
      end
    end
  end
end
