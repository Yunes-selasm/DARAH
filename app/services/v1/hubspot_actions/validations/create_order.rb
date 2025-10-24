module V1::HubspotActions::Validations
  class CreateOrder < Base
    def validate!
      # params.param!(:customer_name, String)
      # params.param!(:product, String)
      # params.param!(:quantity, String)
      # params.param!(:order_number, String)
      # params.param!(:order_status, String)
      # params.param!(:order_date, String)
      # params.param!(:amount, String)
      # params.param!(:address, String)
      # params.param!(:phone, String)
      params.param!(:account, Hash, blank: false, required: true) do |hash|
        hash.param!(:account_type, String, blank: false, required: true, in: %w[company contact])
        hash.param!(:id, String, blank: false, required: true)
        hash.param!(:mobile_number, String)
        hash.param!(:email, String)


        if hash.params[:account_type] == 'company'
          hash.param!(:organization_name, String)
        else
          hash.param!(:full_name, String)
          hash.param!(:gender, String)
        end
      end
    end
  end
end
