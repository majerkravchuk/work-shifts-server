require 'email_loader/base'
require 'email_loader/validation'
require 'email_loader/from_xlsx'

module EmailLoader
  def self.table_name_prefix
    'email_loader_'
  end
end
