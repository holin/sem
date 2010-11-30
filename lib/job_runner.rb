rails_root = "#{File.dirname(__FILE__)}/.."
require "#{rails_root}/config/environment"
require "#{rails_root}/lib/spiders"  

log = Logger.new("#{rails_root}/log/job_runner.log")

Job.all(:conditions => ["done_at is null"]).each do |job|
  begin
    job.run
  rescue Exception => e
    log.error "#{e.message}:#{e.backtrace}"
  end 
end

Job.all(:conditions => ["is_loop = ? and (theday <> ? or theday is null)", true, Date.today.to_s]).each do |job| 
  begin
    job.run
  rescue Exception => e
    log.error "#{e.message}:#{e.backtrace}"
  end 
end