def find_files(dir, name)
  require 'find'
  list = []
  Find.find(dir) do |path|
    Find.prune if [".", ".."].include? path
    case name
    when String
      list << path if File.basename(path) == name
    when Regexp
      list << path if File.basename(path) =~ name
    else
      raise ArgumentError
    end
  end
  list
end

namespace :tech_debt do
  desc "Extract tech_debt markup and create HTML from it."
  task :extract => :environment do
    
    # Parse input
    base_path = ENV['base_path'] || "./"
    app_type = ENV['app_type'] ? ENV['app_type'].to_sym : :rails

    # Create initial path structure
    input_paths = case app_type
    when :rails
      ["app", "test"]
    else
      raise "Unknown application type #{app_type}."
    end
    
    puts "Extracting tech_debt markup."
    puts "Extracting #{app_type} application at base path #{base_path}"
    
    # Get input files
    puts "Extract files from #{input_paths.join(", ")}."
    input_files = []
    for path in input_paths
      input_files += find_files(path, /\w+.rb\Z/)
    end
    
    TechDebt.delete_all
    # Extract markup
    input_files.each_with_index do |input_file, i|
      puts "#{input_file.ljust(70)} (#{i+1}/#{input_files.size})"
      File.open(input_file) do |f|
        text = f.read
        matches = text.scan(TechDebt.pattern)
        for match in matches
          p match
          TechDebt.create(:title => match[3],
                          :priority => match[1].to_i,
                          :location => input_file,
                          :keywords => match[2].split(" "),
                          :reporter => match[4].blank? ? "Anon." : match[4])
        end
      end
    end
    
    TechDebt.all.each do |td|
      puts "#{td.location.ljust(50)}|#{td.keywords.join(", ").ljust(20)} (#{td.priority}): #{td.title} // #{td.reporter}"
    end
  end

  desc "Extract tech_debt markup and create HTML from it."
  task :show => :environment do
    TechDebt.all.each do |td|
      puts "#{td.location.ljust(50)}|#{td.keywords.join(", ").ljust(20)} (#{td.priority}): #{td.title} // #{td.reporter}"
    end
  end
end
