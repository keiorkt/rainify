ActiveAdmin.register Event do
  permit_params :calendar_id, :summary, :identifier, :start_at, :end_at
end
