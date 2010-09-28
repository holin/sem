module Spider
  class Yododo < Base
    # return agent
    def login
      return unless @browser.blank?
      agent = Mechanize.new
      # pp agent.methods.sort.grep(/agent/)
      agent.user_agent_alias = 'Mac Safari'

      # pp agent.user_agent

      page = agent.get('http://www.yododo.com/user/login.ydd')
      # pp page
      login_form = page.form("UserForm")

      # raise page.methods.sort.join("\n")


      login_form.field_with(:name => "user.email").value = "holin.he@gmail.com"
      login_form.field_with(:name => "user.password").value = "heweilin" 

      
      page = login_form.click_button
      
      @browser = agent
    end
    
    def run(job) 
      #login first
      self.login 
      
      post, link = job.post, job.link
      
      #http://www.yododo.com/guide/guides.ydd?sortColumn=g.createtime
      if link.url.starts_with?("http://www.yododo.com/guide/guides.ydd")
        list(job)
      else
        detail(job)
      end
      
    end
    
    
    def detail(job)
      unless job.done_at.nil? #防止重复发
        log.info "job.inspect already done!"
        return
      end 
      post, link = job.post, job.link
      #url http://www.yododo.com/user/01294E6A52F519AEFF808081294CAFF3
      page = browser.get(link.url)
       
      form = page.form_with(:action => "/comments/addComments.ydd")
      
      form["comment"] = post.content
      
      page = form.click_button
      
      job.done_at = Time.now
      job.theday = Date.today.to_s
      job.save
    end
    
    def list(job)
      post, link = job.post, job.link
      #url http://www.yododo.com/user/01294E6A52F519AEFF808081294CAFF3
      page = browser.get(link.url)
      host = "http://www.yododo.com"
      
      page.links_with(:href => /^\/guide\/(\d|\w)+$/).each do |link|
        _link = Link.find_or_create_by_url "#{host}#{link.href}"
        _job = Job.find_or_create_by_post_id_and_link_id(post.id, _link.id)
        begin
          detail(_job)
        rescue Exception => e
          log.error "#{e.message}:#{e.backtrace}"
        end 
      end
      
      job.done_at = Time.now
      job.theday = Date.today.to_s
      job.save
    end
  end
end