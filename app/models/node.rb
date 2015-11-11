class Node < ActiveRecord::Base
  has_many :log_lines
  default_scope -> { order(:name) }

  alias_attribute :to_s, :name
end
