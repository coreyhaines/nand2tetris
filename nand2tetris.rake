
desc "Runs all the test files in directory"
task :all do |task|
  @task = task
  allfiles = "*.tst"
  runtest allfiles
end

desc "Runs a single test file in directory"
task :one, :filename do |task, args|
  @task = task
  filename = "#{args[:filename].capitalize}.tst"
  if test_file_there?(filename) then
    runtest filename
  else
    puts "Could not find file: #{filename}"
  end
end

def test_file_there?(filename)
  File.exist?(set_filename_to_current_dir(filename))
end

def set_filename_to_current_dir(filename)
  File.join(@task.application.original_dir,filename)
end

def runtest(filename)
  runner="../tools/HardwareSimulator.sh"
  pass_regex = /Comparison ended successfully/
  Dir[set_filename_to_current_dir(filename)].each do |f|
    result = `#{runner} #{f}`
    output = if result =~ pass_regex then
          "😸"
        else
          "😡"
        end
    puts "#{File.basename(f)}#{output}"
  end
end
