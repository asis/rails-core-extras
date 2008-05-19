# Load all the extensions
Dir.glob(File.join(File.dirname(__FILE__), "lib", "*.rb")) { |f| require f }

ActiveRecord::Base.send(:include, RailsCoreExtras::TransactionExtensions)