json.array!(@projects) do |project|
  json.extract! project, :id, :name, :gps_position, :target_group, :rating
  json.url project_url(project, format: :json)
end
