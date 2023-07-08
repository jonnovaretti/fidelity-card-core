class CardsController < AuthenticationController
  before_action :set_company
  before_action :set_customer
  before_action :set_card, only: %i[show edit update destroy]

  def show; end

  def new
    @card = @customer.cards.build
  end

  def edit; end

  def create
    @card = @customer.cards.build(card_params.merge(company: @company))

    respond_to do |format|
      if @card.save
        format.html { redirect_to company_customer_path(@company, @customer), notice: 'Card was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update_score(card_params[:score])
        format.html { redirect_to company_customer_url(@company, @customer), notice: 'Card was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to company_customer_cards_url(@company, @customer), notice: 'Card was successfully destroyed.' }
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_customer
    @customer = @company.customers.find(params[:customer_id])
  end

  def card_params
    params.require(:card).permit(:name, :score, :max_score, :expires_at)
  end
end
