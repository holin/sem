class Account < ActiveRecord::Base
  def run_worker
    "Spider::#{self.worker}".constantize.new(self).login.run
  end
end
