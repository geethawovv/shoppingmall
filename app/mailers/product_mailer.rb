class ProductMailer < ApplicationMailer
  def sample_email(product,user)
    @product = product
    @user = user
    before_time = 30.minutes
    mail_time = @product.sale_time - before_time
    # if  @product.sale_time == Time.now.utc.localtime
    mail(to: @user.email, subject: "your favourite product sale time starts!")
    # end
  end
end
