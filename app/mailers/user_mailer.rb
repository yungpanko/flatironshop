class UserMailer < ApplicationMailer
  default from: 'notifications@flatironshop.com'

  def welcome_email(user)
    @user = user
    @url = 'http://flatironshop.com'
    mail(to: @user.email, subject: "Welcome to FlatironShop!")
  end

  def order_email(user, order)
    @user = user
    @order = order
    @url = 'http://flatironshop.com'
    mail(to: @user.email, subject: "Thank you for your order!")
  end

end
