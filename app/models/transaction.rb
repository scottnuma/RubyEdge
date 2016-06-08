class Transaction < ActiveRecord::Base
  # include ActiveModel::Model
  # attr_accessor :amount
  # attr_accessor :description
  # attr_accessor :date
  #
  validates_presence_of :amount
  validates_presence_of :description
  validates_presence_of :date

  # These conditions are checks with @transaction.save,
  # which is a method from ActiveRecord::Base
  # validates :description, presence: true, length: { minimum: 3 }
  # validates :amount, presence: true
  # validates :date, presence:
  #

  def balance
    total = 0
    Transaction.all.each do |t|
      total += t.amount
    end
    return total
  end

  def testy
    puts "yup"
    "okie"
  end

  def to_s
    "Transaction(#{@amount}, #{@description}, #{@date})"
  end

  def inspect
    # These variables currently aren't initialized
    amt, desc, dat = @amount, @description, @date
    amt ||= "nil"
    desc ||= "nil"
    dat ||= "nil"

    "Transaction(#{amt}, #{desc}, #{dat})"
  end

end
