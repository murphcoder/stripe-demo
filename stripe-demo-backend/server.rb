require 'stripe'
require 'sinatra'

# This is your real test secret API key.
Stripe.api_key = 'sk_test_51Jqs98IHnITDo4ldUwmD77Ryiu61jgTcTTul6JtrWZ54uIQI1EYuxiEucOR5ba2Ri7pI6EKBFLaVyHJJuGpLEhzO00IsYRS5bc'

set :static, true
set :port, 4242

YOUR_DOMAIN = 'https://pandia-stripe-demo-frontend.herokuapp.com/checkout'

get '/' do
  'Working!'
end

post '/create-checkout-session' do
  content_type 'application/json'

  session = Stripe::Checkout::Session.create({
    line_items: [{
      price: 'price_1JqsDlIHnITDo4ldzvlf2gVP',
      quantity: 1,
    }],
    payment_method_types: [
      'card',
    ],
    mode: 'payment',
    success_url: YOUR_DOMAIN + '?success=true',
    cancel_url: YOUR_DOMAIN + '?canceled=true',
  })
  redirect session.url, 303
end