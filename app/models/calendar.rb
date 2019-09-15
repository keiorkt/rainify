class Calendar < ApplicationRecord
  include GoogleCalendar

  has_many :events

  def import
    service = activate_service
    response = service.list_calendar_lists
    response.items.each do |entry|
      calendar = Calendar.find_or_initialize_by(owner_identifier: entry.id)
      calendar.update_attributes(summary: entry.summary, is_primary: !!entry.primary?)
      calendar.save!
    end
  end
end