module Spider
  class Base 
    attr_accessor :browser, :log, :account
    def initialize(account)
      @account = account
      rails_root = "#{File.dirname(__FILE__)}/../.."
      @log = Logger.new("#{rails_root}/log/job_runner.log")
    end
    
    def login
      raise "login method"
    end
    
    def run
      raise "run method"
    end
    
    def cache
      @cache ||= {}
    end
    
    def skip_me
      rand > 0.6
    end
    
  end
end