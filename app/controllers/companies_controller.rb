class CompaniesController < AuthenticationController
  before_action :set_company, only: %i[show edit update destroy]

  def index
    @companies = Company.where(user: current_user)
  end

  def show; end

  def new
    @company = Company.new
  end

  def edit; end

  def create
    @company = Company.new(company_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: 'Company was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params.merge(user_id: current_user.id))
        format.html { redirect_to company_url(@company), notice: 'Company was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_company
    @company = Company.find_by(id: params[:id], user: current_user)
  end

  def company_params
    params.require(:company).permit(:name, :description, :phone)
  end
end
