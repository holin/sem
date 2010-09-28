class Job < ActiveRecord::Base
  belongs_to :link
  belongs_to :post
  
  def run
    get_spider.new.run(self)
  end
  
  def get_spider
    uri = URI.parse(self.link.url)
    if uri.host == "www.yododo.com" 
      return Spider::Yododo
    end
    nil
  end
end
