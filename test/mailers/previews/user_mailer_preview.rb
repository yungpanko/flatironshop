# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def order_email
    UserMailer.order_email(User.first, User.first.orders.last)
  end
end
