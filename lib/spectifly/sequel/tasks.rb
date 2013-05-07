path = File.join(File.dirname(__FILE__), '../../tasks/*.rake')
Dir.glob(path).each {|r| load r}
