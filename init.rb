class ActiveRecord::Base
  named_scope :td_conditions, lambda { |*args| {:conditions => args} }
end

#require 'will_paginate' unless Kernel.const_defined? 'WillPaginate'
#WillPaginate.enable
#TechDebtsController.view_paths = [File.join(directory, 'views')]
