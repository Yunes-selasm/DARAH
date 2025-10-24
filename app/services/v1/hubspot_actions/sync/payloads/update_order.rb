module V1::HubspotActions::Sync::Payloads
  class UpdateOrder < Base
    def call
      inputs = []

      actions.each do |action|
        inputs.concat(build_order_payload(action))
      end

      return inputs if inputs.blank?

      Hubspot::Crm::Deals::BatchInputSimplePublicObjectBatchInput.new(inputs:)
    end

    def build_order_payload(action)
      body = action.body
      user_address = action.body['user_address'] || {}
      order_products = action.body['order_products']

      order_products.filter_map do |product|
        next if deal_id(product['id']).blank?

        {
          id: deal_id(product['id']),
          properties: {
            dealstage: AppConfig.deal_pipeline_stage_id,
            account_id: action.body['account']['id'],
            db_id: product['id'],
            total_amount: body['amount'],
            dealname: SERVICES_NAMES['create_order'],
            unique_order_id: product['id'],
            unique_order_number: body['order_number'],
            order_quantity: product['quantity'],
            orders_status: body['status'],
            payments_status: body['payment_status'],
            shipment_status: body['shipment_status'],
            product_total_amount: product['total'],
            order_created_at: body['created_at'],
            user_city: user_address['city'],
            product_id: product['product_id'],
            product_name: product['product_name'],
            product_quantity: product['quantity'],
            user_address: user_address['address'],
            user_state: user_address['state'],
            user_country: user_address['country'],
            user_additional_phone: user_address['phone'],
            last_updated_at: DateTime.current.to_s
          }
        }
      end
    end

    def deal_id(action_id)
      filters = [
        { property_name: 'db_id', operator: 'EQ', value: action_id }
      ]

      V1::HubspotClient::Deals.search_by(filters).results.first&.id
    end
  end
end

