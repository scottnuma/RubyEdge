# Class for storing information about monetary purchases.
class Transaction < ActiveRecord::Base
  validates_presence_of :amount
  validates_presence_of :label
  validates_presence_of :date

	# TODO this doesn't work except for the date
  def to_s
		"Transaction(#{@label}, #{@amount}, #{@withdrawal}, #{@date})"
  end

  # Returns the string form of the transaction.
  # Accounts for missing fields
  def inspect
    # These variables currently aren't initialized
    amt, desc, dat, with = @amount, @label, @date, @withdrawal
    amt ||= "nil"
    desc ||= "nil"
    dat ||= "nil"
		with ||= "nil"
		
    "Transaction(#{desc}, #{amt}, #{with}, #{form_date})"
  end
  # Returns a formatted string of the date.
  def form_date
    "#{date.month}/#{date.day}/#{date.year - 2000}"
  end

  # Returns the positive / negative amount depending upon if 
  # the Transaction is a withdrawal.
  def form_amount
    if withdrawal != nil
      if withdrawal
        return amount * -1
      else
        return amount
      end
    end
    return amount
  end

  # Returns a string of the withdrawal status.
  def withdrawal_label
	  if withdrawal
		  return "withdrawal"
	  else
		  return "deposit"
	  end
  end

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Transaction.create! row.to_hash
		end
	end

end
