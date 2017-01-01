class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.select { |t| t[:user_id] == session[:user_id] }
    @total = 0
    @transactions.each do |t|
      @total += t.form_amount()
    end

    respond_to do |format|
      format.html
      format.csv { send_data to_csv(@transactions), filename: "ruby-edge-#{Date.today}.csv"}
    end
  end

	# Returns a CSV file containing all the user's transactions
  def to_csv (transactionSubset)
		# The attributes to include in the csv
    attributes = %w{label amount withdrawal date}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      transactionSubset.each do |transaction|
          csv << attributes.map { |attr| transaction.send(attr)}
      end
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
    checkPermissions(@transaction)
  end

  def new
  end

  def edit
    @transaction = Transaction.find(params[:id])
    checkPermissions(@transaction)
  end

  def create
    # Add the date into the argument if nothing is added
    @transaction = Transaction.new(transaction_params)

    # The save method also validates the instance
    if @transaction.save
      redirect_to @transaction
    else
      # In case of failure, go ahead and create a new transaction
      render 'new'
      # @transaction still holds the old transaction, and thus has the
      # errorneous arguments
    end
  end

  def update
    @transaction = Transaction.find(params[:id])
    checkPermissions(@transaction)
    if @transaction.update(transaction_params)
      redirect_to @transaction
    else
      render 'edit'		
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    checkPermissions(@transaction)
    @transaction.destroy
    redirect_to transactions_path
  end

  private
    def transaction_params
      # Add an extra argument that doens't originate in the format
      # Rather pull from the current user
      params[:transaction][:user_id] = session[:user_id]
      puts params[:transaction][:user_id]

      params.require(:transaction).permit(:label, :amount, :date, :withdrawal, :user_id)
    end

    def checkPermissions(transactionToCheck)
      if (transactionToCheck && transactionToCheck[:user_id] != session[:user_id])
        flash.keep[:alert] = "You lack view permissions for this transaction"
        redirect_to root_path
			end
    end
end
