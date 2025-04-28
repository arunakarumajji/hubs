class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation_email.subject
  #
  def invitation_email
    @user = params[:user]
    @hub = @user.hub
    @email_config = params[:email_config]
    @signup_url = user_signup_url(hub_slug: @hub.slug, user_id: @user.id)
    @greeting = "Hi"

    mail(
      to: @user.email,
      from: @email_config.from_email,
      subject: @email_config.subject,
      )
  end
end
