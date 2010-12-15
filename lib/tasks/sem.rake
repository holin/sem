namespace :app do 
  desc "USAGES: rake app:can_link" 
  task :can_link, :needs => :environment do |t, args|
    Account.all.each do |account|
      if account.memo.to_s =~ /可发外链/
        account.can_link = true
        account.memo = account.memo.to_s.gsub("(可发外链)", "")
        account.save
      end
    end
    puts 'finished'
  end 
  
end