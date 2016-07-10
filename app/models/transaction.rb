class Transaction < ActiveRecord::Base
  # include ActiveModel::Model
  # attr_accessor :amount
  # attr_accessor :description
  # attr_accessor :date
  #
  validates_presence_of :amount
  validates_presence_of :description
  validates_presence_of :date

  def testin
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

    "Transaction(#{amt}, #{desc}, #{form_date})"
  end

  def self.to_csv
    attributes = %w{amount form_date description}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map { |attr| user.send(attr)}
      end
    end
  end

  def form_date
    "#{date.month}/#{date.day}/#{date.year - 2000}"
  end
end
