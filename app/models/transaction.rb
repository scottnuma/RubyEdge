class Transaction < ActiveRecord::Base

  validates_presence_of :amount
  validates_presence_of :label
  validates_presence_of :date
  # validates_presence_of :withdrawal

  def testin
    puts "yup"
    "okie"
  end

  def to_s
    "Transaction(#{@amount}, #{@label}, #{@date})"
  end

  def inspect
    # These variables currently aren't initialized
    amt, desc, dat = @amount, @label, @date
    amt ||= "nil"
    desc ||= "nil"
    dat ||= "nil"

    "Transaction(#{amt}, #{desc}, #{form_date})"
  end

  def self.to_csv
    attributes = %w{amount form_date label}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |transaction|
          csv << attributes.map { |attr| transaction.send(attr)}
      end
    end
  end

  def form_date
    "#{date.month}/#{date.day}/#{date.year - 2000}"
  end

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

  def withdrawal_label
	  if withdrawal
		  return "withdrawal"
	  else
		  return "deposit"
	  end
  end

end
