# encoding: utf-8

require "#{File.dirname(__FILE__)}/base"
module Spider
  class Huaqiao < Base
    # it discuz
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
      # puts login_form.inspect
      login_form.username = account.name
      login_form.password = account.password
      page = login_form.click_button 
      
      @browser = agent
      return self
    end
    
    def run
      water
    end
    
    def water
      puts "water"
      msg = %w(那分走人，{:6_216:} 我来签到了{:7_263:}，加威望阿，呵呵 坚持 努力{:8_336:} 我又来了{:8_327:})
      (241..279).each do |i|
        msg << "{:7_#{i}:}"
      end
      page = browser.get("http://www.52huaqiao.com/club/forumdisplay.php?fid=6")
      arr = []
      page.search("tbody[@id^='normalthread']").each do |tbody|
        tbody.search("th.subject a").each do |link|
          href = link["href"]
          next if href =~ /page=\d+$/
          arr << "http://www.52huaqiao.com/club/#{href}"
        end
      end
      
      add_friend(get_user_ids(page)) 

      arr.each do |link|
        next if skip_me
        puts "#{link} at #{Time.now}"
        
        begin
          page = browser.get(link)
          form = page.forms.last
          form.message = msg[rand(msg.size)]
          form.click_button
          add_friend(get_user_ids(page)) 
        rescue Exception => e
          puts e
        end
        
        
        sleep 30
      end
      
      
       
    end #edn water
    
    def login_home
      puts "login_home"
      # return unless @browser.blank?
      agent = Mechanize.new
      # pp agent.methods.sort.grep(/agent/)
      agent.user_agent_alias = 'Mac Safari'

      # pp agent.user_agent

      page = agent.get("http://www.52huaqiao.com/home/index.php")
            # 
            # real_login_url = "http://www.52huaqiao.com/home/#{page.search("div.nav_account a")[1]["href"]}"
            # puts real_login_url
            # page = agent.get(real_login_url)
            # 
      
      login_form = page.forms.first  
      # puts login_form.inspect
      login_form.username = account.name
      login_form.password = account.password
      page = login_form.click_button 
      
      @browser = agent
      return self
    end
    
    def post_blog
      login_home
      
      page = browser.get("http://www.52huaqiao.com/home/cp.php?ac=blog")
      login_form = page.forms.first   
    
      login_form.subject = "新人报道"
      login_form.message = '<b><a href="space.php?do=album">相册</a></b>'
      page = login_form.click_button 
      
    end
    
    def add_friend(ids) 
      ids = ids.to_a
      puts "add friends #{ids} at #{Time.now}"
      ids.each do |id|
        next if skip_me
        page = browser.get("http://www.52huaqiao.com/club/my.php?item=buddylist&newbuddyid=#{id}&buddysubmit=yes&inajax=1&ajaxtarget=ajax_buddy_0_menu_content") 
        sleep 10
      end
    end
    
    def get_user_ids(doc)
      arr = []
      doc.search("a[@href^='space.php?uid=']").each do |link|
        if link["href"] =~ /space\.php\?uid=(\d{3,})/
          arr << $1
        end
      end
      arr.uniq
    end
         
  end
end

class String
  def utf8_to_gb2312
    encode_convert(self, "gb2312", "UTF-8")
  end 
  
  def gbk_to_utf8
    encode_convert(self, "UTF-8", "gbk")
  end

  private
  def encode_convert(s, to, from)
    require 'iconv'
    begin
      converter = Iconv.new(to, from)
      converter.iconv(s)
    rescue
      s
    end
  end
end

s = "搞笑".utf8_to_gb2312
require 'uri'
puts URI.escape(s)
"http://index.baidu.com/main/word.php?word=%B8%E3%D0%A6"

if __FILE__ == $0
  require "#{File.dirname(__FILE__)}/../../config/environment"
  # Spider::Huaqiao.new(Account.last).login.run
  Spider::Huaqiao.new(Account.last).login.post_blog
end