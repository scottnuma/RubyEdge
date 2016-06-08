class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    @total = 0
    Transaction.all.each do |t|
      @total += t.amount
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
  end

  def edit
    @transaction = Transaction.find(params[:id])
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
    end
  end

  def update
    @transaction = Transaction.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to @transaction
    else
      render 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to transactions_path
  end

  private
    def transaction_params
      params.require(:transaction).permit(:description, :amount, :date)
    end
end
