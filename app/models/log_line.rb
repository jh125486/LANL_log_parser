class LogLine < ActiveRecord::Base
  has_one :node
  store_accessor :info
  # store_accessor :info, :process
  # store_accessor :info, :pid

  def self.parse(line)
    line = line.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    time = line[0..14]
    node, line = line[15..-1].chomp.split(' ', 2)
    { node: node, timestamp: Time.zone.parse(time), message: line, info: process_info(line) }
  end

  def to_s
    "Line ##{number}"
  end

  private

  def self.process_info(line)
    return unless line =~ /^(.+?): (.+)/
    if line =~ /^(\w+)\[(\d+)\]:/
      { process: Regexp.last_match[1], pid: Regexp.last_match[2] }
    else
      line =~ /^(.+?): (.+)/
      { process: Regexp.last_match[1] }
    end
  end
end
