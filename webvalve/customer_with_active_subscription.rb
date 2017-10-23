module CustomerWithActiveSubscription
  extend self

  def build
    {
      customer: {
        id: "cbra_development_1-b4a797c8",
        merchant_id: "dgr73gtg4krxny2y",
        first_name: nil,
        last_name: nil,
        company: nil,
        email: "b@b.com",
        phone: nil,
        fax: nil,
        website: nil,
        created_at: "2017-10-15 20:59:21 UTC",
        updated_at: "2017-10-15 20:59:21 UTC",
        custom_fields: "",
        credit_cards: [
         {
           bin: "411111",
           card_type: "Visa",
           cardholder_name: nil,
           commercial: "Unknown",
           country_of_issuance: "Unknown",
           created_at: "2017-10-15 20:59:21 UTC",
           customer_id: "cbra_development_1-b4a797c8",
           customer_location: "US",
           debit: "Unknown",
           default: true,
           durbin_regulated: "Unknown",
           expiration_month: "12",
           expiration_year: "2023",
           expired: false,
           healthcare: "Unknown",
           image_url: "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox",
           issuing_bank: "Unknown",
           last_4: "1111",
           payroll: "Unknown",
           prepaid: "Unknown",
           product_id: "Unknown",
           subscriptions: [
            {
              add_ons: [],
              balance: "0.00",
              billing_day_of_month: 15,
              billing_period_end_date: "2017-11-14",
              billing_period_start_date: "2017-10-15",
              created_at: "2017-10-15 20:59:22 UTC",
              updated_at: "2017-10-15 21:00:56 UTC",
              current_billing_cycle: 1,
              days_past_due: nil,
              discounts: [],
              failure_count: 0,
              first_billing_date: "2017-10-15",
              id: "33twyw",
              merchant_account_id: "bethelmusic",
              never_expires: true,
              next_bill_amount: "19.95",
              next_billing_period_amount: "19.95",
              next_billing_date: "2017-11-15",
              number_of_billing_cycles: nil,
              paid_through_date: "2017-11-14",
              payment_method_token: "88b57y",
              plan_id: "monthly_subscription",
              price: "19.95",
              status: "Active",
              trial_duration: nil,
              trial_duration_unit: nil,
              trial_period: false,
              descriptor: {:name=>nil, :phone=>nil, :url=>nil},
              description: nil,
              transactions: [
                {
                  id: "pcr1fq3b",
                  status: "settled",
                  type: "sale",
                  currency_iso_code: "USD",
                  amount: "19.95",
                  merchant_account_id: "bethelmusic",
                  sub_merchant_account_id: nil,
                  master_merchant_account_id: nil,
                  order_id: nil,
                  created_at: "2017-10-15 20:59:22 UTC",
                  updated_at: "2017-10-15 22:08:39 UTC",
                  customer: {
                    id: "cbra_development_1-b4a797c8",
                    first_name: nil,
                    last_name: nil,
                    company: nil,
                    email: "b@b.com",
                    website: nil,
                    phone: nil,
                    fax: nil
                  },
                  billing: {
                    id: nil,
                    first_name: nil,
                    last_name: nil,
                    company: nil,
                    street_address: nil,
                    extended_address: nil,
                    locality: nil,
                    region: nil,
                    postal_code: nil,
                    country_name: nil,
                    country_code_alpha2: nil,
                    country_code_alpha3: nil,
                    country_code_numeric: nil
                  },
                  refund_id: nil,
                  refund_ids: [],
                  refunded_transaction_id: nil,
                  partial_settlement_transaction_ids: [],
                  authorized_transaction_id: nil,
                  settlement_batch_id: "2017-10-15_bethelmusic_m59wtz7g",
                  shipping: {
                    id: nil,
                    first_name: nil,
                    last_name: nil,
                    company: nil,
                    street_address: nil,
                    extended_address: nil,
                    locality: nil,
                    region: nil,
                    postal_code: nil,
                    country_name: nil,
                    country_code_alpha2: nil,
                    country_code_alpha3: nil,
                    country_code_numeric: nil},
                  custom_fields: "",
                  avs_error_response_code: nil,
                  avs_postal_code_response_code: "I",
                  avs_street_address_response_code: "I",
                  cvv_response_code: "I",
                  gateway_rejection_reason: nil,
                  processor_authorization_code: "ZPQV86",
                  processor_response_code: "1000",
                  processor_response_text: "Approved",
                  additional_processor_response: nil,
                  voice_referral_number: nil,
                  purchase_order_number: nil,
                  tax_amount: nil,
                  tax_exempt: false,
                  credit_card: {
                    token: "88b57y",
                    bin: "411111",
                    last_4: "1111",
                    card_type: "Visa",
                    expiration_month: "12",
                    expiration_year: "2023",
                    customer_location: "US",
                    cardholder_name: nil,
                    image_url: "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox",
                    prepaid: "Unknown",
                    healthcare: "Unknown",
                    debit: "Unknown",
                    durbin_regulated: "Unknown",
                    commercial: "Unknown",
                    payroll: "Unknown",
                    issuing_bank: "Unknown",
                    country_of_issuance: "Unknown",
                    product_id: "Unknown",
                    unique_number_identifier: "0a7ed8bb36b4f43c7cc6a306cfda0c2e",
                    venmo_sdk: false
                  },
                  status_history: [
                    {
                      timestamp: "2017-10-15 20:59:22 UTC",
                      status: "authorized",
                      amount: "19.95",
                      user: "trueinviso@gmail.com",
                      transaction_source: "recurring"
                    },
                    {
                      timestamp: "2017-10-15 20:59:22 UTC",
                      status: "submitted_for_settlement",
                      amount: "19.95",
                      user: "trueinviso@gmail.com",
                      transaction_source: "recurring"
                    },
                    {
                      timestamp: "2017-10-15 22:08:39 UTC",
                      status: "settled",
                      amount: "19.95",
                      user: nil,
                      transaction_source: ""
                    }
                  ],
                  plan_id: "monthly_subscription",
                  subscription_id: "33twyw",
                  subscription: {
                    billing_period_end_date: "2017-11-14",
                    billing_period_start_date: "2017-10-15"
                  },
                  add_ons: [],
                  discounts: [],
                  descriptor: {:name=>nil, :phone=>nil, :url=>nil},
                  recurring: true,
                  channel: nil,
                  service_fee_amount: nil,
                  escrow_status: nil,
                  disbursement_details: {
                    disbursement_date: "2017-10-16",
                    settlement_amount: "19.95",
                    settlement_currency_iso_code: "USD",
                    settlement_currency_exchange_rate: "1",
                    funds_held: false,
                    success: true
                  },
                  disputes: [],
                  authorization_adjustments: [],
                  payment_instrument_type: "credit_card",
                  processor_settlement_response_code: "",
                  processor_settlement_response_text: "",
                  three_d_secure_info: nil
                }
              ]
            }
          ]
        }
      ]
    }
   }
  end
end