puts "STRIPE_PUBLISHABLE_KEY: #{ENV['pk_test_51NbVICSE1z0d8MiFqLCWaAmttVC0phnNkWGLjSPSHcywQHyusJP6ySQrOvWwMlvuR3wytly8p3pdFPauSFFXUISO00J7ufsyhb']}"
puts "STRIPE_SECRET_KEY: #{ENV['sk_test_51NbVICSE1z0d8MiFLyY0blmEpcnqzqS0F0AgXMbmHraqRS325ZmnveqldOilOFqtACIUFOWLjZIQ59fravOtJi5L00Qrwxc2WL']}"

Rails.configuration.stripe = {
  :publishable_key => ENV['pk_test_51NbVICSE1z0d8MiFqLCWaAmttVC0phnNkWGLjSPSHcywQHyusJP6ySQrOvWwMlvuR3wytly8p3pdFPauSFFXUISO00J7ufsyhb'],
  :secret_key => ENV['sk_test_51NbVICSE1z0d8MiFLyY0blmEpcnqzqS0F0AgXMbmHraqRS325ZmnveqldOilOFqtACIUFOWLjZIQ59fravOtJi5L00Qrwxc2WL']
}


Stripe.api_key = Rails.configuration.stripe[:secret_key]