# encoding: utf-8
require "rubygems"
require "xmlrpc/client"
class XMLRPC::Client
  def set_debug
    @http.set_debug_output($stderr);
  end
end

# Make an object to represent the XML-RPC server.
# http://www.52huaqiao.com/home/xmlrpc.php
server = XMLRPC::Client.new("www.52huaqiao.com", "/home/xmlrpc.php")
# server = XMLRPC::Client.new2("http://localhost:9999/")

server.set_debug

 

content = {:title => "new", :description => "one"}
result  = server.call("metaWeblog.newPost", 12853, "gaoxiaodd", "heweilin", content, true)
