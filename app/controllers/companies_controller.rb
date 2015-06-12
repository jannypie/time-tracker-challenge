class CompaniesController < ApplicationController
  before_action :set_company, only: %i(update destroy show)

  def index
    @companies = Company.all
  end

  def create
    @company = Company.create company_params
    render status: 201
  end

  def show
  end

  def update
    @company.update_attributes company_params
  end

  def destroy
    @company.destroy
  end

  private

  def company_params
    attrs = %i(name address1 address2 address3 city state
               zip phone1 phone2 fax1 fax2 email website)
    params.require(:company).permit(*attrs)
  end

  def set_company
    @company = Company.find params[:id]
  end
end
