class Plan < ActiveRecord::Base
  def make_jobs
    self.post_ids.split(",").each do |post_id|
      self.link_ids.split(",").each do |link_id|
        job = Job.find_or_create_by_link_id_and_post_id(link_id, post_id)
      end
    end
  end
end
