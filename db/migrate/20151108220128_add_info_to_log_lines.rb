class AddInfoToLogLines < ActiveRecord::Migration
  def up
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :log_lines, :info, :hstore

#    LogLine.reset_column_information
#    LogLine.all.each do |log_line|
#      if log_line.pid
#        log_line.info = { pid: log_line.pid, process: log_line.process }
#      elsif log_line.process
#        log_line.info = { process: log_line.process }
#      end
#      log_line.save
#    end
  end
end
