log_file = Rails.root + 'test' + 'factories' + 'messages.log'
log = Log.find_or_create_by file: log_file

from = log.log_lines.order(:number).last.number
from ||= 0
log.process_log_file(from)
