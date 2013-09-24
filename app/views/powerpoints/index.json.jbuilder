json.array!(@powerpoints) do |powerpoint|
  json.extract! powerpoint, :user_id, :title, :description
  json.url powerpoint_url(powerpoint, format: :json)
end
