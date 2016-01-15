require 'rake/testtask'

namespace :spec do
  Rake::TestTask.new :unit do |t|
    t.libs << 'lib' << 'spec'
    t.test_files = FileList['spec/*_spec.rb'].exclude(/integration/)
    t.verbose = true
  end
  Rake::TestTask.new :integration do |t|
    t.libs << 'lib' << 'spec'
    t.test_files = ['spec/integration_spec.rb']
    t.verbose = true
  end
end

task default: ['spec:unit', 'spec:integration']
