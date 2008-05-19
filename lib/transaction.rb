module RailsCoreExtras
  #
  # Some utility methods for transaction-related operations
  #
  module TransactionExtensions
    #
    # Exception raised when there is no open transaction in the current 
    # context
    #
    class WithinTransactionError < Exception
      def initialize
      	super("No open transactions in the current thread")
      end
    end
    
    module Methods
      #
      # Raise a #WithinTransactionError when there is no open transaction in the
      # current thread context
      #
      def assert_within_transaction
	      raise WithinTransactionError.new unless within_transaction?
      end
      
      #
      # Returns +true+ when called within a transaction, +false+ otherwise
      #
      def within_transaction?
	      !Thread.current['open_transactions'].nil? && 
	        Thread.current['open_transactions'] > 0
      end
    end
    
    #
    # Make methods available as instance and class methods
    #
    def self.included(base)
      base.send(:include, Methods)
      base.extend(Methods)
    end
  end
end
