json.companies do
  json.array! @companies, partial: 'companies/company', as: :company
end
