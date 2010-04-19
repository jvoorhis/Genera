require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << '/Users/jvoorhis/Projects/ruby-llvm/lib' # development only
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test
