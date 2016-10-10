require 'bigdecimal'

railsrc_path = File.expand_path('~/.railsrc')
if ( ENV['RAILS_ENV'] || defined? Rails ) && File.exist?( railsrc_path )
  begin
    load railsrc_path
  rescue Exception
    warn "Could not load: #{ railsrc_path }" # because of $!.message
  end
end

def trace
  yield
rescue => e
  puts "Error during processing: #{$!}"
  bt = e.backtrace.select{|line| !line.include?("/.rvm/")}
  puts "Backtrace: \n\t#{bt.join("\n\t")}"
end


class BigDecimal
  def inspect
    to_s('f')
  end
end
