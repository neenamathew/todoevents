class Todoevent < ActiveRecord::Base
  validates :name, presence: true
  before_save :default_values


  def default_values
    self.status ||= 'active'
  end

  #Check status of event
  def status_check(event_detail)
    input_status = event_detail.status
    return input_status
  end

  def self.filter(search)
    if search == "active"
      where(' (status) IN (?) ', "active")
    elsif search == "completed"
      where(' (status) IN (?) ', "completed")
    else
      all
    end
  end

end
