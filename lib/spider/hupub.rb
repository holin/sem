require "#{File.dirname(__FILE__)}/base"
module Spider
  class Hupub < Base
    # return agent
    def login
      puts "login"
      return unless @browser.blank?
      agent = Mechanize.new
      # pp agent.methods.sort.grep(/agent/)
      agent.user_agent_alias = 'Mac Safari'

      # pp agent.user_agent

      page = agent.get(account.url)
      login_form = page.forms.first  
      login_form.username = account.name
      login_form.password = account.password
      page = login_form.click_button 
      
      @browser = agent
      return self
    end
    
    def run
      check_in
    end
    
    def check_in
      puts "check in"
      arr = %w(我来签到了:lol，加威望阿，呵呵 坚持 努力，签到！:$ 我又来了:victory:)
      page = browser.get("http://www.hupub.com/thread-33431-1-1.html")
      form = page.forms.last
      form.message = arr[rand(arr.size)]
      form.click_button
    end
     
  end
end

if __FILE__ == $0
  require "#{File.dirname(__FILE__)}/../../config/environment"
  Spider::Hupub.new(Account.last).login.run
end