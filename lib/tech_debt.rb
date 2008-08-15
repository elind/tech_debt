# TechDebt
class TechDebt < ActiveRecord::Base
  serialize :keywords

  def self.pattern
    /^[ ]*(## td)[ ]*(?:\((\d+)\))?([\w ]*)?:?([\w !&%#,:;+\-\?\.=]*)(?:\/\/)?([\w ]*)/i
  end
end