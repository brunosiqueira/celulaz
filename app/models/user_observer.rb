class UserObserver < ActiveRecord::Observer
 
  def after_create(user)
    UserMailer.delay.deliver_signup_notification(user) if user.self_created
    user_director = User.find :first,:conditions=>"type='UserDirector'"
    if user_director
      UserMailer.delay.deliver_notify_director(user_director, user)
    end
  end
  
  def after_save(user)
    if user.self_created
      UserMailer.delay.deliver_activation(user) if user.pending?
    else
      UserMailer.delay.deliver_welcome(user) if user.pending?
    end
    UserMailer.delay.deliver_forgot_password(user) if user.recently_forgot_password?
    UserMailer.delay.deliver_reset_password(user) if user.recently_reset_password?
  end
end
