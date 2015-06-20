class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show, :destroy]

  def index
    # @customers = Customer.page(params[:page])
    @q = Customer.ransack(params[:q])
    @customers = @q.result.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params_customer)
    # the save is where validates happens
    if @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(params_customer)
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

private

  def params_customer
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email_string,
      :company_id
      )
  end
end
