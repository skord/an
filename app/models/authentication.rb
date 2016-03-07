class Authentication < ActiveRecord::Base
  belongs_to :user
  serialize :info
  serialize :extra
  serialize :credentials
end
