module CustomerResponse
  extend self

  def build(attributes = {})
    {
      customer: {
        id: attributes[:id] || Random.new.rand(100000),
        merchant_id: Random.new.rand(1000000),
        first_name: attributes[:first_name],
        last_name: attributes[:last_name],
        company: attributes[:company],
        email: attributes[:email],
        phone: attributes[:phone],
        fax: attributes[:fax],
        website: attributes[:website],
        created_at: Time.current,
        updated_at: Time.current,
        custom_fields: "",
        credit_cards: [
          {
            billing_address: {
              id: "cx",
              customer_id: attributes[:id] || Random.new.rand(100000),
              first_name: attributes[:first_name],
              last_name: attributes[:last_name],
              company: attributes[:company],
              street_address: nil,
              extended_address: nil,
              locality: nil,
              region: nil,
              postal_code: "94107",
              country_code_alpha2: nil,
              country_code_alpha3: nil,
              country_code_numeric: nil,
              country_name: nil,
              created_at: Time.current,
              updated_at: Time.current
            },
            bin: "401288",
            card_type: "Visa",
            cardholder_name: nil,
            commercial: "Unknown",
            country_of_issuance: "",
            created_at: Time.current,
            customer_id: "testing_8035",
            customer_location: "US",
            debit: "Unknown",
            default: true,
            durbin_regulated: "Unknown",
            expiration_month: "12",
            expiration_year: "2020",
            expired: false,
            healthcare: "Unknown",
            image_url:
             "https://assets.braintreegateway.com/payment_method_logo/visa.png?environment=sandbox",
            issuing_bank: "Unknown",
            last_4: "1881",
            payroll: "Unknown",
            prepaid: "No",
            product_id: "Unknown",
            subscriptions: [],
            token: "7nnpsd",
            unique_number_identifier: "71509b7379519fb767523e297c3a48fb",
            updated_at: Time.current,
            venmo_sdk: false,
            verifications: [],
          }
        ],
        addresses: [
          {
            id: "cx",
            customer_id: "testing_8035",
            first_name: nil,
            last_name: nil,
            company: nil,
            street_address: nil,
            extended_address: nil,
            locality: nil,
            region: nil,
            postal_code: "94107",
            country_code_alpha2: nil,
            country_code_alpha3: nil,
            country_code_numeric: nil,
            country_name: nil,
            created_at: Time.current,
            updated_at: Time.current
          }
        ]
      }
    }
  end
end
