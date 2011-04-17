require "fileutils"

#File.new"picture"
#puts Dir.glob "*"
list = Dir.glob "public/pictures/*"
#puts list
list.each{|p|
    FileUtils.mkdir(p+"/line/")
    dir = Dir.glob p+"/original/*.*"
    puts dir
    FileUtils.cp_r dir, p+"/line/" unless dir.empty?
}
