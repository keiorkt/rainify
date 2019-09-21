class Event < ApplicationRecord
  include GoogleCalendar

  belongs_to :calendar

  scope :tomorrow_events, -> { where('start_at between ? and ?', Time.new.tomorrow.change(hour: 00, min: 00, sec: 00), (Time.new+2.days).change(hour: 00, min: 00, sec: 00)) }

  def import
    Calendar.where(notify: true).each do |calendar|
      import_from(calendar.owner_identifier, 30)
    end
  end

  def import_from(calendar_id = "primary", max_results_num = 30)
    service = activate_service
    response = service.list_events(calendar_id,
                                  max_results: max_results_num,
                                  single_events: true,
                                  order_by: "startTime",
                                  time_min: DateTime.now.rfc3339,
                                  time_zone: "Asia/Hong_Kong")

    return if response.items.empty?
    response.items.each do |item|
      start_at = item.start.date || item.start.date_time
      end_at = item.end.date || item.end.date_time
      calendar_record_id = (calendar_id == "primary") ? Calendar.find_by!(is_primary: true).id : Calendar.find_by!(owner_identifier: calendar_id).id
      event = Event.find_or_initialize_by(identifier: item.id)
      event.update_attributes(summary: item.summary, start_at: start_at, end_at: end_at, calendar_id: calendar_record_id)
      event.save!
    end
  end

  def delete_needless_data
    Event.where('end_at < ?', Time.now).destroy_all
  end
end