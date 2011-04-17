class TitleObserver < ActiveRecord::Observer
  def after_update(title)
    if title.status == Title::STATUS_ACATADO
      TitleMailer.delay.deliver_accepted(title)
    end
  end
end
