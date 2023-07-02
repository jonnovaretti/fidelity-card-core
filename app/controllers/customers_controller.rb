class CustomersController < AuthenticationController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :set_company

  def index
    @customers = Customer.where(company: @company)
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.new(customer_params.merge(company_id: @company.id))

    respond_to do |format|
      if @customer.save
        format.html do
          redirect_to company_customer_url(company_id: @company.id, id: @customer.id),
                      notice: 'Customer was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html do
          redirect_to company_customer_url(company_id: @company.id, id: @customer.id),
                      notice: 'Customer was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to company_customers_url(@company), notice: 'Customer was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_company
    @company = Company.find { |company| company.id == params[:company_id].to_i && company.user_id == current_user.id }
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:name, :phone)
  end
end
