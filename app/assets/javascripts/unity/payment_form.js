function braintree_setup(token) {
  require.config({
    paths: {
      braintreeClient: 'https://js.braintreegateway.com/web/3.29.0/js/client.min',
      hostedFields: 'https://js.braintreegateway.com/web/3.29.0/js/hosted-fields.min'
    }
  });

  require(['braintreeClient', 'hostedFields'], function(client, hostedFields) {
  client.create({
    authorization: token,
    }, function(err, clientInstance) {
      if(err) {
        console.error(err);
        return;
      }
      hostedFields.create(
        {
          client: clientInstance,
          styles: {
            input: {
              "font-size": "14px",
              "font-family": "sans-serif",
              color: "#181818",
            },
          },
          fields: {
            number: {
              selector: "#card-number",
              placeholder: "1234  4567  8910  9876",
            },
            expirationMonth: {
              selector: "#card-expire-month",
              placeholder: "12",
            },
            expirationYear: {
              selector: "#card-expire-year",
              placeholder: "2019",
            },
            cvv: {
              selector: "#cvv-field",
              placeholder: "CVV",
            },
          },
        },
      );
    });
  });
}
