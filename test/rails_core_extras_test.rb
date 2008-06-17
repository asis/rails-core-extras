require 'test/unit'
require 'lib/transaction'

class RailsCoreExtrasTest < Test::Unit::TestCase

  include RailsCoreExtras::TransactionExtensions

  #
  # Test the plugin code without using AR libraries. PLugin code is almost 
  # independent from AR. AR dependency checks will be tested later
  #
  def test_plugin_outside_AR
    
    assert_raises WithinTransactionError do
      assert_within_transaction
    end
        
    assert_nothing_raised do
      mock_AR_transaction do
        assert_within_transaction
      end
    end
    
    assert_nothing_raised do
      mock_AR_transaction do
        mock_AR_transaction do
          assert_within_transaction
        end
      end
    end    
    
  end
  
  protected 
  
    #
    # For this plugin an Active Record transaction is only a reference counter
    # stored on the current thread.
    #
    def mock_AR_transaction
      Thread.current['open_transactions'] ||= 0

      Thread.current['open_transactions'] += 1
      yield 
      Thread.current['open_transactions'] -= 1
    end
  
end
