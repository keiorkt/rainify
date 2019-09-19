namespace :basic_job do
  desc 'Do the basic job for this application'
  task :collect => :environment do
    BatchService.new.do
  end
end
